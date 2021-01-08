<template>
  <form class="form-signup" @submit.prevent="updatePost">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="form-group">
      <label for="title">Title</label>
      <input v-model="post.title" type="title" class="form-controll" id="title">
    </div>
    <button type="submit" class="btn btn-primary mb-3">Edit</button>
    <!-- <button type="submit" class="btn btn-primary mb-3">Destroy</button> -->
  </form>
</template>

<script>
  import {
    simpleAxios,
    secureAxios
  } from '../backend/axios.js'

  const POST_EDIT_URL = '/api/v1/posts/'

  export default {
    name: "postEdit",
    data() {
      return {
        post: ''
      }
    },
    created() {
      this.checkUsersPost()
      this.getPost()
    },
    methods: {
      getPost() {
        simpleAxios.get(POST_EDIT_URL + `${this.$route.params.id}` + `/edit`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        if (!response.data) {
          this.Failed(response)
          return
        }
        this.post = response.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      },
      updatePost() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.patch(POST_EDIT_URL + `${this.$route.params.id}`, {
            title: this.post.title
          })
          .then(response => this.updateSuccessdul(response))
          .catch(error => this.Failed(error))
      },
      destroyPost() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.delete(POST_EDIT_URL + `${this.$route.params.id}`)
          .then(response => this.updateSuccessdul(response))
          .catch(error => this.Failed(error))
      },
      updateSuccessdul(response) {
        if (!response.data) {
          this.Failed(response)
          return
        }
        this.$router.replace('/')
      },
      checkUsersPost() {
        if (!(this.$store.state.signedIn && this.$store.getters.currentUserId)) {
          this.$router.replace('/')
        }
      }
    }
  }
</script>