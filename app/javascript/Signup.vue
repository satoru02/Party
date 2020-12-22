<template>
 <form class="form-signup" @submit.prevent="signup">
   <div class="alert alert-danger" v-if="error">{{ error }}</div>
   <div class="form-group">
     <label for="email">Email address</label>
     <input v-model="email" type="email" class="form-controll" id="email">
   </div>
   <div class="form-group">
     <label for="password">Password</label>
     <input v-model="password" type="password" class="form-controll" id="password">
   </div>
   <div class="form-group">
      <label for="password">Password Confirmation</label>
      <input v-model="password_confirmation" type="password" class="form-controll" id="password_confirmation">
   </div>
   <button type="submit" class="btn btn-primary mb-3">Sign up</button>
   <div>
     <router-link to="/login">Sign in</router-link>
   </div>
 </form>

</template>

<script>
import axios from 'axios'

const API_URL = '/api/v1/signup'
const signupAxios = axios.create({
  withCredential: true,
  headers: {
    'Content-Type': 'application/json'
  }
})

export default {
  name: 'Signup',
  data() {
    return {
      email: '',
      password: '',
      password_confirmation: '',
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
    signup() {
      signupAxios.post(
      API_URL,
      {
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation
      })
      .then(response => this.signupSuccessful(response))
      .catch(error => this.signupFailed(error))
    },
    signupSuccessful(response) {
      if(!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/')
    },
    signupFailed(error) {
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