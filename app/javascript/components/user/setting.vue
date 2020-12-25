<template>
  <form class="form-signup" @submit.prevent="saveProfile">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="form-group">
      <label for="email">Email address</label>
      <input v-model="user.email" type="email" class="form-controll" id="email">
    </div>
    <div class="form-group">
      <label for="about">About</label>
      <input v-model="user.about" type="about" class="form-controll" id="about">
    </div>
    <div class="form-group">
      <label for="name">name</label>
      <input v-model="user.name" type="name" class="form-controll" id="name">
    </div>
    <div class="form-group">
      <label for="username">username</label>
      <input v-model="user.username" type="username" class="form-controll" id="username">
    </div>
    <div class="form-group">
      <label for="location">location</label>
      <input v-model="user.location" type="location" class="form-controll" id="location">
    </div>
    <div class="form-group">
      <label for="web_url">website_url</label>
      <input v-model="user.web_url" type="web_url" class="form-controll" id="web_url">
    </div>
    <div class="form-group">
      <label for="youtube_url">youtube_url</label>
      <input v-model="user.youtube_url" type="youtube_url" class="form-controll" id="youtube_url">
    </div>
    <div class="form-group">
      <label for="facebook_url">facebook_url</label>
      <input v-model="user.facebook_url" type="facebook_url" class="form-controll" id="facebook_url">
    </div>
    <div class="form-group">
      <label for="instagram_url">instagram_url</label>
      <input v-model="user.instagram_url" type="instagram_url" class="form-controll" id="instagram_url">
    </div>
    <div class="form-group">
      <label for="filmarks_url">filmarks_url</label>
      <input v-model="user.filmarks_url" type="filmarks_url" class="form-controll" id="filmarks_url">
    </div>
    <button type="submit" class="btn btn-primary mb-3">Save profile</button>
  </form>
</template>

<script>
  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios.js'
  const USER_URL = '/api/v1/users/'

  export default {
    name: 'Setting',
    data() {
      return {
        user: '',
      }
    },
    created() {
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if (this.$store.state.checkSignedIn) {
          this.$router.replace('/')
        }
        this.getUserInformation()
      },
      getUserInformation() {
        simpleAxios.get(USER_URL + `${this.$store.state.currentUser.id}` + `/edit`)
          .then(response => this.fetchSuccessful(response))
          .catch(error => this.Failed(error))
      },
      fetchSuccessful(response) {
        if (!response.data) {
          this.Failed(response)
          return
        }
        this.user = response.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      saveProfile() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.patch(USER_URL + `${this.$store.state.currentUser.id}`, {
            email: this.user.email,
            about: this.user.about,
            name: this.user.name,
            username: this.user.username,
            location: this.user.location,
            web_url: this.user.web_url,
            youtube_url: this.user.youtube_url,
            facebook_url: this.user.facebook_url,
            instagram_url: this.user.instagram_url,
            filmarks_url: this.user.filmarks_url,
          })
          .then(response => this.updateSuccessdul(response))
          .catch(error => this.Failed(error))
      },
      updateSuccessdul(response) {
        if (!response.data) {
          this.Failed(response)
          return
        }
        this.$router.replace('/setting')
      }
    }
  }
</script>

<style>
  input {
    color: white;
    font-family: 'Open Sans', sans-serif;
    font-size: 20;
    font-weight: bold;
  }
</style>