<template>
  <div class="homes">
    <div v-for="post in posts" :key="post.id" :title="post.title" :url="post.url" :time="post.created_at">
      <h3>{{ post.title }}</h3>
      <a v-bind:href="post.url">{{ post.url }}</a>
      <p>{{ post.created_at }}</p>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'home',
    props: {
      title: String,
      url: String,
      time: String,
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
