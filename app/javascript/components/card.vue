<template>
  <div>
    <v-container class="mt-8">
      <v-row no-gutters>
        <v-col v-for="post in posts" :key="post.id" :title="post.title" :url="post.url" :time="post.date" :user_id="post.user_id"
          class="mb-9 pr-7" cols="12" sm="4">
          <v-card class="rounded-xl" color="#010101" max-width="400">
            <v-card-title>
            </v-card-title>
            <v-card-text class="mr-n14 mt-7">
              <a v-bind:href="post.url">{{ post.title }}</a>
            </v-card-text>
            <v-card-actions>
              <v-list-item class="grow">
                <router-link :to="{ name: 'User', params: {id: `${post.user_id}` }}">
                  <avatar></avatar>
                </router-link>
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
    <infinite-loading spinner="spiral" @infinite="infiniteHandler"></infinite-loading>
  </div>
</template>

<script>
  import {
    simpleAxios
  } from '../backend/axios.js'
  import Avatar from '../components/perpage/TheAvatar.vue';
  import InfiniteLoading from 'vue-infinite-loading';

  const CONTENT_URL = 'api/v1/posts'

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