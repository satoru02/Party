<template>
  <div class="card" style="grid-area:card" infinite-wrapper>
    <v-container class="mt-16" >
      <v-row no-gutters>
        <v-col v-for="post in posts" :key="post.id" :title="post.title" :time="post.date" :user_id="post.user_id"
          class="mb-9 pr-10" cols="12" sm="16">
          <v-card class="rounded-xl" elevation="0" color="#05070f" max-width="680" max-height="400">
            <v-card-title>
              <v-list-item-avatar color="darken-3" size=25>
                <v-icon style="color:white" size=22>mdi-bell</v-icon>
              </v-list-item-avatar>
              <div class="pr-5" style="color:white; font-size: 13px;">Category</div>
            </v-card-title>
            <v-card-text class="mr-n14 mt-9" align="center">
              <h2 style="color:white;">{{ post.title }}</h2>
            </v-card-text>
            <v-card-text class="mr-n14 " align="center">
              <p style="color:white; font-size: 15px;" class="font-weight-light">Sacriel is the premier strategic combat and survival specialist on Twitch, providing educational analysis seasoned with dry British humour. Started in 2012</p>
            </v-card-text>
            <v-card-actions>
              <v-list-item class="grow">
                <router-link :to="{ name: 'User', params: {id: `${post.user_id}` }}">
                  <!-- <avatar></avatar> -->
                  <v-list-item-avatar color="white darken-3" size=30>
                    <v-img class="elevation-1" alt=""
                      src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light">
                    </v-img>
                  </v-list-item-avatar>
                </router-link>
                <v-list-item-content>
                  <v-list-item-subtitle style="color:white">John Smith</v-list-item-subtitle>
                </v-list-item-content>
                <v-row align="center" justify="end">
                  <span class="subheading mr-2 mt-5 color:white" style="font-size: 13px">{{ post.date }}</span>
                </v-row>
                <v-btn v-if="$store.state.currentUser.id !== post.user_id" text color="primary"
                  @click="entryRequest(post.id, post.user_id)">
                  Join
                </v-btn>
              </v-list-item>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <infinite-loading spinner="spiral" @infinite="infiniteHandler"></infinite-loading>
  </div>
</template>

<script>
  import {
    simpleAxios,
    secureAxios
  } from '../backend/axios.js'
  import Avatar from '../components/perpage/TheAvatar.vue';
  import InfiniteLoading from 'vue-infinite-loading';

  const CONTENT_URL = '/api/v1/posts'
  const ENTRY_URL = '/api/v1/entries'

  export default {
    name: 'Card',
    components: {
      'avatar': Avatar,
      'infinite-loading': InfiniteLoading,
    },
    props: {
      title: {
        status: {
          type: String,
          required: true,
        }
      },
      time: {
        status: {
          type: String,
          required: true,
        }
      },
      user_id: {
        status: {
          type: String,
          required: true
        }
      }
    },
    data() {
      return {
        page: 1,
        pageSize: 9,
        posts: [],
      }
    },
    methods: {
      entryRequest(post, user) {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(ENTRY_URL, {
            post: post,
            user: user
          })
          .catch(error => this.setError(error, "Cannot post"))
      },
      infiniteHandler($state) {
        simpleAxios.get(CONTENT_URL, {
            params: {
              page: this.page,
              per_page: this.pageSize,
            },
          })
          .then((res) => {
            setTimeout(() => {
              if (res.data.length) {
                this.page += 1;
                this.posts.push(...res.data);
                $state.loaded();
              } else {
                $state.complete();
              }
            }, 1000)
          })
      }
    },
  }
</script>