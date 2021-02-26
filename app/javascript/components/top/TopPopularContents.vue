<template>
  <v-sheet class="rounded-lg" width=340 color="#11151c"
    style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 420px; max-width: 100%; max-height:1000px; min-width: 275px;">
    <v-row no-gutters>
      <v-col lg=1 />
      <v-col lg=10 align="start" class="mt-6">
        <h3 class="text">Pickup Events</h3>
      </v-col>
      <v-col lg=1 />
    </v-row>
    <v-row>
      <v-col lg=12 />
    </v-row>

    <v-row v-for="(post ,index) in posts" :key="index" class="mt-n2">
      <v-col lg=1 />
      <v-col lg=7>
        <h3 @click="movePost(post)" class="events">{{ post.attributes.title }}</h3>
      </v-col>
      <v-col lg=1 class="mt-1">
        <v-btn width="10" height="14" color="pink">
          new
        </v-btn>
      </v-col>
    </v-row>
  </v-sheet>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const POPULARITY_URL = `/api/v1/posts/popularity`
  export default {
    name: 'TopPopularContents',
    data() {
      return {
        posts: [],
        error: ''
      }
    },
    created() {
      this.fetchPosts()
    },
    methods: {
      fetchPosts() {
        secureAxios.get(POPULARITY_URL)
         .then(res => this.Successful(res))
         .catch(error => this.Failed(error))
      },
      Successful(res){
        this.posts = res.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      movePost(post){
        this.$router.push({
          name: 'Search',
          params: {
            query: post.attributes.title
          }
        })

      }
    }
  }
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

  .text {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    color: #ffffff;
  }

  .events {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    color: #929ba5;
    font-size: 0.8rem;
    cursor: pointer;
  }

  .events:hover {
    color: #ffffff;
    cursor: pointer;
  }

  .v-btn:not(.v-btn--round).v-size--default {
    min-width: 0;
  }
</style>