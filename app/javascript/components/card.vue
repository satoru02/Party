<template>
  <div class="card" style="grid-area:card" infinite-wrapper>
    <v-row no-gutters>
      <v-col class="d-flex" md="4" offset-md="3"></v-col>
      <v-col class="d-flex mt-5 mb-n7" md="2" offset-md="2">
        <v-select label="Trend" dense outlined class="rounded-lg"></v-select>
      </v-col>
    </v-row>
    <v-container>
      <v-row no-gutters>
        <v-col v-for="post in posts" :key="post.attributes.id" :title="post.attributes.title" :time="post.attributes.date" :user_id="post.attributes.user_id"
          class="mb-9 pr-10" cols="12" sm="16">
          <v-hover v-slot="{ hover }">
            <v-card :class="{ 'on-hover': hover }" :elevation="hover ? 16 : 0" class="rounded-xl" color="#05070f"
              max-width="680" max-height="400">
              <v-card-title>
                <v-list-item-avatar color="darken-3" size=25>
                  <v-icon style="color:white" size=22>🎬</v-icon>
                </v-list-item-avatar>
                <div class="mr-12" style="color:white; font-size: 13px;">Movie</div>
              </v-card-title>
              <v-card-text class="mt-1" align="center">
                <h2 style="color:white;">{{ post.attributes.title }}</h2>
              </v-card-text>
              <v-card-text class="mr-n14 " align="center">
                <p style="color:white; font-size: 15px;" class="font-weight-light">Sacriel is the premier strategic
                  combat and survival specialist on Twitch, providing</p>
              </v-card-text>
              <v-card-actions>
                <v-list-item class="grow">
                  <router-link :to="{ name: 'User', params: {id: `${post.attributes.user_id}` }}">
                    <v-list-item-avatar color="white darken-3" size=30>
                      <v-img class="elevation-1" alt=""
                        src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light">
                      </v-img>
                    </v-list-item-avatar>
                  </router-link>
                  <v-list-item-content>
                    <v-list-item-subtitle class="mr-16" style="color:white">John Smith</v-list-item-subtitle>
                  </v-list-item-content>
                  <v-row align="center" justify="end">
                    <span class="subheading mr-2 mt-5 color:white" style="font-size: 13px">{{ post.attributes.date }}</span>
                  </v-row>
                  <v-btn v-if="$store.state.currentUser.id !== post.attributes.user_id && post.attributes.can_request_entry === true" text color="primary"
                    @click="entryRequest(post.attributes.id, post.attributes.user_id), dialog = true">
                    Join
                  </v-btn>
                </v-list-item>
              </v-card-actions>
            </v-card>
          </v-hover>
        </v-col>
      </v-row>
    </v-container>
    <infinite-loading spinner="spiral" @infinite="infiniteHandler"></infinite-loading>
    <div class="dialog">
      <v-dialog light v-model="dialog" width="500">
        <v-card>
          <v-card-title>エントリー完了！</v-card-title>
　　　　　　<v-card-text>エントリーが完了しました。オーガナイザーが承認すれば、イベントに参加出来ます。</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" text @click="dialog = false">
              Close
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
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
        dialog: false
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
              user_id: `${this.$store.state.currentUser.id}`,
            },
          })
          .then((res) => {
            setTimeout(() => {
              if (res.data.data.length) {
                this.page += 1;
                this.posts.push(...res.data.data);
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

<style scoped>
  .v-card {
    transition: opacity .4s ease-in-out;
  }

  .v-card:not(.on-hover) {
    opacity: 1;
  }
</style>