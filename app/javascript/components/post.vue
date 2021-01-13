<template>
  <form class="form-signup">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="form-group">
      <label for="title">Title</label>
      <input v-model="title" type="text" class="form-controll" id="title">
    </div>
    <div class="form-group">
      <label for="content">Content</label>
      <input v-model="content" type="text" class="form-controll" id="content">
    </div>
    <div class="form-group">
      <label for="category">Category</label>
      <input v-model="category" type="text" class="form-controll" id="category">
    </div>
    <div class="form-group">
      <label for="tag">Tags</label>
      <input v-model="tag_list" type="text" class="form-controll" id="tag">
    </div>
    <v-btn text color="primary" @click="postUrl(title, content, tag_list)">
      submit
    </v-btn>
  </form>
</template>

<script>
  import {
    secureAxios
  } from '../backend/axios.js'
  const POST_URL = '/api/v1/posts'

  export default {
    name: "post",
    data() {
      return {
        title: '',
        content: '',
        category: '',
        tag_list: ''
      }
    },
    methods: {
      setError(error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      postUrl(title, content, tag_list) {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(POST_URL, {
            title: title,
            category_id: 1,
            content: content,
            tag_list: tag_list
          })
          .then(response => {
            this.$router.replace('/')
          })
          .catch(error => this.setError(error, "Cannot post"))
      }
    }
  }
</script>