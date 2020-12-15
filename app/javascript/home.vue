<template>
  <div class="homes" infinite-wrapper>
    <!-- <post></post>
    <about></about> -->
    <!-- <card></card> -->
    <v-container class="mt-8">
      <v-row no-gutters>
        <v-col v-for="post in posts" :key="post.id" :title="post.title" :url="post.url" :time="post.date"
          class="mb-9 pr-7" cols="12" sm="4">
          <v-card class="rounded-xl" color="#010101" max-width="400">
            <v-card-title>
            </v-card-title>
            <v-card-text class="mr-n14 mt-7">
              <a v-bind:href="post.url">{{ post.title }}</a>
            </v-card-text>
            <v-card-actions>
              <v-list-item class="grow">
                <avatar></avatar>
                <v-list-item-content>
                  <v-list-item-subtitle>John Smith</v-list-item-subtitle>
                </v-list-item-content>
                <v-row align="center" justify="end">
                  <span class="subheading mr-2 mt-5" style="color:white">{{ post.date }}</span>
                </v-row>
              </v-list-item>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <infinite-loading force-use-infinite-wrapper spinner="spiral" @infinite="infiniteHandler"></infinite-loading>
  </div>
</template>

<script>
  import axios from 'axios';
  import post from './components/post.vue';
  import card from './components/card.vue';
  import about from './components/TheAbout.vue';
  import Avatar from './components/TheAvatar.vue';
  import InfiniteLoading from 'vue-infinite-loading';

  export default {
    name: 'home',
    components: {
      'post': post,
      'card': card,
      'about': about,
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
      url: {
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
    },
    data() {
      return {
        page: 1,
        pageSize: 9,
        posts: [],
      }
    },
    methods: {
      infiniteHandler($state) {
        axios.get('api/v1/posts', {
            params: {
              page: this.page,
              per_page: this.pageSize,
            },
          })
          .then((res) => {
            if (res.data.length) {
              this.page += 1;
              this.posts.push(...res.data);
              $state.loaded();
            } else {
              $state.complete();
            }
          })
      }
    },
  }
</script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat&family=Open+Sans:wght@400;700&display=swap');

  p {
    color: white;
    font-family: 'Open Sans', sans-serif;
    font-size: 20;
    font-weight: bold;
  }

  a {
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    text-decoration: none;
  }

  span {
    font-family: 'Open Sans', sans-serif;
    font-size: 10;
  }
</style>