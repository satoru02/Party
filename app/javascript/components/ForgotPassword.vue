<template>
  <form class="form-app form-forgot-password" @submit.prevent="submit">
    <div class="alert alert-info" v-if="notice">{{ notice }}</div>
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="form-group">
      <label for="email">Email address</label>
      <input type="email" v-model="email" class="form-control" id="email">
    </div>
    <button type="submit" class="btn btn-primary mb-3">Reset Password</button>
    <div>
      <router-link to="/login">Sign in</router-link>
      <router-link to="/signup">Sign up</router-link>
    </div>
  </form>
</template>

<script>
import { simpleAxios } from '../backend/axios.js'
const PASSWORD_RESET_URL = '/api/v1/password_resets';

export default {
  name: "ForgotPassword",
  data () {
    return {
      email: '',
      error: '',
      notice: '',
    }
  },
  methods: {
    submit () {
      simpleAxios.post(PASSWORD_RESET_URL, { email: this.email })
      .then(() => this.submitSuccessful())
      .catch(error => this.submitFailed())
    },
    submitSuccessful () {
      this.notice = 'Email with reset password istructions had been sent.'
      this.error = ''
      this.email = ''
    },
    submitFailed (error) {
      this.error =  (error.response && error.response.data && error.response.data.error) || ''
    }
  }
}
</script>