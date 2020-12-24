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
      <br />
      <router-link to="/forgot_password">Forgot Password</router-link>
    </div>
  </form>
</template>

<script>
  import {
    simpleAxios
  } from './backend/axios.js'
  const LOGIN_URL = '/api/v1/login'
  const USER_INFO_URL = '/api/v1/users/me'

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
      this.checkSignedIn()
    },
    updated() {
      this.checkSignedIn()
    },
    methods: {
      signin() {
        simpleAxios.post(LOGIN_URL, {
            email: this.email,
            password: this.password,
          })
          .then(response => this.signinSuccessful(response))
          .catch(error => this.signinFailed(error))
      },
      signinSuccessful(response) {
        if (!response.data.csrf) {
          this.signinFailed(response)
          return
        }
        simpleAxios.get(USER_INFO_URL)
          .then(me_response => {
            this.$store.commit('setCurrentUser', {
              currentUser: me_response.data,
              csrf: response.data.csrf
            })
            this.error = ''
            this.$router.replace('/')
          })
          .catch(error => this.signinFailed(error))
      },
      signinFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$store.commit('unsetCurrentUser')
      },
      checkSignedIn() {
        if (this.$store.state.signedIn) {
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