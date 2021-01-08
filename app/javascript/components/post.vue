<template>
  <form class="form-signup">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="form-group">
      <label for="title">Title</label>
      <input v-model="title" type="title" class="form-controll" id="title">
    </div>
    <v-btn text color="primary" @click="postUrl(title)">
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
        category: ''
      }
    },
    methods: {
      setError(error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      postUrl(title) {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(POST_URL, {
            title: title,
            category_id: 1,
          })
          .then(response => {
            this.$router.replace('/')
          })
          .catch(error => this.setError(error, "Cannot post"))
      }
    }
  }
</script>