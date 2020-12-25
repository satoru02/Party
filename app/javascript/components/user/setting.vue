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
    <button type="submit" class="btn btn-primary mb-3">Save profile</button>
    </form>
</template>

<script>
import { simpleAxios, secureAxios } from '../../backend/axios.js'
const USER_URL = '/api/v1/users/'

export default {
  name: 'Setting',
  data() {
    return {
      user: '',
      email: '',
      name: '',
      username: '',
      about: '',
      location: '',
      web_url: '',
      youtube_url: '',
      facebook_url: '',
      instagram_url: '',
      filmarks_url: '',
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
      if(!response.data){
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
      secureAxios.patch(USER_URL + `${this.$store.state.currentUser.id}`,{
        email: this.user.email,
        about: this.user.about,
      })
      .then(response => this.updateSuccessdul(response))
      .catch(error => this.Failed(error))
    },
    updateSuccessdul(response) {
      if(!response.data){
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