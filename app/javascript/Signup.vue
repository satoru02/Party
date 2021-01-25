<template>
  <div justify="center" align="center">
    <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1);" color="#212529" height="630" class="rounded-lg mt-16"
      width="650">
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=8 class="mt-8">
          <h1>Create an account</h1>
        </v-col>
      </v-row>

      <v-row>
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

      <v-row class="mt-n4">
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

      <v-row class="mt-n4">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=4>
          <h3 style="color:#edf2f4;">PASSWORD CONFIRMATION</h3>
        </v-col>
      </v-row>
      <v-row class="mt-n4">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-text-field v-model="password_confirmation" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=12></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-btn @click="signup()" large depressed block color="#2d00f7">
            <v-row>
              <v-col cols=12 md=5></v-col>
              <v-col cols=12 md=2>
                <p class="mt-4" style="font-size:0.8rem;">Login</p>
              </v-col>
            </v-row>
          </v-btn>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="ml-n2 mt-n4">
          <router-link :to="{name: 'login'}">
            <p style="font-size:0.7rem; color:#6c757d;">I already have an account</p>
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
  const SIGNUP_URL = '/api/v1/signup'

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
      this.checkSignedIn()
    },
    updated() {
      this.checkSignedIn()
    },
    methods: {
      signup() {
        simpleAxios.post(SIGNUP_URL, {
            email: this.email,
            password: this.password,
            password_confirmation: this.password_confirmation
          })
          .then(response => this.signupSuccessful(response))
          .catch(error => this.signupFailed(error))
      },
      signupSuccessful(response) {
        this.$router.replace({name: "check", params: {query: this.email}})

        // if (!response.data.csrf) {
        //   this.signnupFailed(response)
        //   return
        // }
        // simpleAxios.get(USER_INFO_URL)
        //   .then(me_response => {
        //     this.$store.commit('setCurrentUser', {
        //       currentUser: me_response.data,
        //       csrf: response.data.csrf
        //     })
        //     this.error = ''
        //     this.$router.replace('/')
        //   })
        //   .catch(error => this.signupFailed(error))
      },
      signupFailed(error) {
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