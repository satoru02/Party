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

const LOGIN_URL = '/api/v1/login'
const USER_INFO_URL = '/api/v1/users/me'
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
    this.checkSignedIn()
  },
  updated() {
    this.checkSignedIn()
  },
  methods: {
    signin() {
      // #First API CALL
      //  => ①cookieにユーザー情報の入ったjwt_tokenをもらう。
      //  => ②responsebodyでcsrf_tokenもらう。
      //  => ③signInの記録を保持する。
      signinAxios.post(LOGIN_URL,
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
      // #Second API CALL
      //  => ①Users controller def me; end
      //  => ②current_userでは、payloadメソッドでdecodeしてuser_idを取得
      signinAxios.get(USER_INFO_URL)
       .then(me_response => {
         this.$store.commit('setCurrentUser', { currentUser: me_response.data, csrf: response.data.csrf })
         this.error = ''
         this.$router.replace('/')
       })
       .catch(error => this.signinFailed(error))
    },
    signinFailed(error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ""
      // delete localStorage.csrf
      // delete localStorage.signedIn
      this.$store.commit('unsetCurrentUser')
    },
    checkSignedIn() {
      // if (localStorage.signedIn) {
      //   this.$router.replace('/')
      // }
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