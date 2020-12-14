<template>
  <div>
    <v-container class="mt-8">
      <v-row no-gutters>
        <v-col class="mb-9 pr-7" v-for="post in posts" :key="post.id" :title="post.title" :url="post.url"
          :time="post.date" cols="12" sm="4">
          <v-card class="rounded-xl" color="#010101" max-width="400">
            <v-card-title>
              <!-- <p>{{ post.title }}</p> -->
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
  </div>
</template>

<script>
  import axios from 'axios';
  import Avatar from '../components/TheAvatar.vue'

  export default {
    name: 'card',
    components: {
      'avatar': Avatar,
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
        posts: [],
      }
    },
    mounted() {
      axios.get('api/v1/posts')
        .then(response => {
          this.posts = response.data
        })
    }
  }
</script>

<style>
</style>