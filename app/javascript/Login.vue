<template>
 <form class="form-signup" @submit.prevent="signin">
   <div class="alert alert-danger" v-if="error">{{ error }}</div>
   <div class="form-group">
     <label for="email">Email address</label>
     <input v-model="email" type="email" class="form-controll" id="email">
   </div>
   <div class="form-group">
     <label for="password">Password</label>
     <input v-model="password" type="password" class="form-controll" id="password">
   </div>
   <button type="submit" class="btn btn-primary mb-3">Sign in</button>
   <div>
     <router-link to="/signup">Sign up</router-link>
   </div>
 </form>
</template>

<script>
import axios from 'axios'

const API_URL = '/api/v1/login'
const signinAxios = axios.create({
  withCredential: true,
  headers: {
    'Content-Type': 'application/json'
  }
})

export default {
  name: 'Signin',
  data() {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created() {
    this.checkSigndIn()
  },
  updated() {
    this.checkSigndIn()
  },
  methods: {
    signin() {
      signinAxios.post(
      API_URL,
      {
        email: this.email,
        password: this.password,
      })
      .then(response => this.signinSuccessful(response))
      .catch(error => this.signinFailed(error))
    },
    signinSuccessful(response) {
      if(!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/')
    },
    signinFailed(error) {
      this.error = (error.response && error.response.data && error.response.data.error) || "Something went wrong"
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSigndIn() {
      if (localStorage.signedIn) {
        this.$router.replace('/')
      }
    }
  }
}
</script>

<style lang="css">
.form-signup {
  width: 70%;
  max-width: 500px;
  padding: 10% 15px;
  margin: 0 auto;
}
</style>