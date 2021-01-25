<template>
  <div justify="center" align="center">
    <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1);" color="#212529" height="630" class="rounded-lg mt-16"
      width="650">
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=8 class="mt-8">
          <h1>Welcome back to KITPAC community!</h1>
          <h2 style="color:#6c757d;">Let's have a party</h2>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-btn large depressed block color="#0a0908">
            <v-row>
              <v-col cols=12 md=3></v-col>
              <v-col cols=12 md=1>
                <v-icon class="ml-4 mt-2">mdi-apple</v-icon>
              </v-col>
              <v-col cols=12 md=3>
                <p class="ml-4 mt-4" style="font-size:0.7rem;">Login with Apple</p>
              </v-col>
              <v-col cols=12 md=3></v-col>
            </v-row>
          </v-btn>
        </v-col>
        <v-col cols=12 md=1></v-col>

      </v-row>
      <v-row class="mt-n3">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-btn large depressed block color="#002642">
            <v-row>
              <v-col cols=12 md=3></v-col>
              <v-col cols=12 md=1>
                <v-icon class="ml-4 mt-2">mdi-google</v-icon>
              </v-col>
              <v-col cols=12 md=3>
                <p class="ml-4 mt-4" style="font-size:0.7rem;">Login with Google</p>
              </v-col>
              <v-col cols=12 md=3></v-col>
            </v-row>
          </v-btn>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <!-- <v-row class="mt-n3">
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=8>
          <v-btn large depressed block color="#1da1f2">
            <v-row>
              <v-col cols=12 md=3></v-col>
              <v-col cols=12 md=1>
                <v-icon class="ml-2 mt-2">mdi-twitter</v-icon>
              </v-col>
              <v-col cols=12 md=3>
                <p class="ml-2 mt-4" style="font-size:0.7rem;">Login with Twitter</p>
              </v-col>
              <v-col cols=12 md=3></v-col>
            </v-row>
          </v-btn>
        </v-col>
      </v-row> -->
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=8>
          <p>or</p>
        </v-col>
      </v-row>
      <v-row class="mt-n10">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=1>
          <h3 style="color:#edf2f4;">EMAIL</h3>
        </v-col>
      </v-row>
      <v-row class="mt-n4">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-text-field v-model="email" outlined filled dense></v-text-field>
        </v-col>
      </v-row>

      <v-row class="mt-n8">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=1>
          <h3 style="color:#edf2f4;">PASSWORD</h3>
        </v-col>
      </v-row>
      <v-row class="mt-n4">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-text-field v-model="password" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-n11 ml-n4">
          <router-link :to="{name: 'ForgotPassword'}">
            <div>
              <p style="font-size:0.7rem; color:#6c757d;">I forgot my password</p>
            </div>
          </router-link>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-btn @click="signin()" large depressed block color="#2d00f7">
            <v-row>
              <v-col cols=12 md=5></v-col>
              <v-col cols=12 md=2>
                <p class="mt-4" style="font-size:1rem;">Login</p>
              </v-col>
            </v-row>
          </v-btn>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="ml-n3 mt-n4">
          <router-link :to="{name: 'signup'}">
            <p style="font-size:0.7rem; color:#6c757d;">I dont have an account</p>
          </router-link>
        </v-col>
      </v-row>

    </v-sheet>
    <v-row class="mt-8">
      <v-col cols=12 md=12></v-col>
    </v-row>
  </div>
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
        simpleAxios.get(USER_INFO_URL, {
          params: {
            position: 'login'
          }
        })
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