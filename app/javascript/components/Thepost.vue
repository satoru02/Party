<template>
  <div class="post-form">
    <h1>Postform配置予定</h1>
    <v-text-field label="Regular" v-model="title" placeholder="Placeholder"></v-text-field>
    <v-text-field label="Regular" v-model="url" placeholder="Placeholder"></v-text-field>
    <v-btn color="success" class="mr-4" @click="postUrl(title, url)">
      Post
    </v-btn>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'post',
    data() {
      return {
        title: '',
        url: ''
      }
    },
    methods: {
      postUrl: function (title, url) {
        axios
          .post('/api/v1/posts', {
            title: title,
            url: url
          })
          .then(function (response) {
            console.log(response)
          })
      }
    }
  }
</script>