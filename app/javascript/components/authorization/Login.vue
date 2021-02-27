<template>
  <div justify="center" align="center">
    <v-row style="height:130;">
      <v-col sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=10 lg=6 xl=6>
        <v-sheet color="#212529"
          :style="sheetStyle"
          elevation=20 class="rounded-lg mt-6">
          <v-row>
            <v-col md=1 lg=1 />
            <v-col cols=12 md=10 lg=10 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-8' : 'mt-0']">
              <div style="font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'text-h5' : 'text-h6']">VIDEOKITコミュニティへようこそ！</div>
              <div style="color:#6c757d; font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'text-h6' : 'text-h7']">好きな友達とパーティしよう。</div>
            </v-col>
            <v-col md=1 lg=1 />
          </v-row>
          <v-row :class="[$vuetify.breakpoint.mdAndUp ? 'mt-0' : 'mt-n5']">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn large depressed block color="#0a0908">
                <v-row>
                  <v-col cols=2 sm=3 md=3 lg=3 xl=3 />
                  <v-col cols=1 sm=1 md=1 lg=1 xl=1>
                    <v-icon class="ml-7 mt-3">mdi-apple</v-icon>
                  </v-col>
                  <v-col cols=3 sm=3 md=3 lg=3 xl=3>
                    <p class="ml-7 mt-4" style="font-size:0.8rem; font-weight:bold;">Appleでログイン</p>
                  </v-col>
                  <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
                </v-row>
              </v-btn>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-row class="mt-n3">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn large depressed block color="#4285f4">
                <v-row>
                  <v-col cols=2 sm=3 md=3 lg=3 xl=3 />
                  <v-col cols=1 sm=1 md=1 lg=1 xl=1>
                    <v-icon class="ml-7 mt-3">mdi-google</v-icon>
                  </v-col>
                  <v-col cols=3 sm=3 md=3 lg=3 xl=3>
                    <p class="ml-7 mt-4" style="font-size:0.8rem; font-weight:bold;">Googleでログイン</p>
                  </v-col>
                  <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
                </v-row>
              </v-btn>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-row class="mt-n3">
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 />
            <v-col cols=8 sm=8 md=8 lg=8 xl=8>
              <div :class="[$vuetify.breakpoint.mdAndUp ? 'h5' : 'caption']">Or</div>
            </v-col>
          </v-row>

          <v-row class="mt-n4">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="email" outlined filled dense placeholder="Eメールアドレス" />
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>

          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field @click="visible = false" v-model="password" :type="visible ? 'text': 'password'" outlined
                dark filled dense placeholder="パスワード" />
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            </v-col>
          </v-row>

          <v-row class="mt-n10">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="signin()" large depressed block color="#2d00f7">
                <v-row>
                  <v-col cols=4 sm=5 md=5 lg=5 xl=5 />
                  <v-col cols=2 sm=2 md=2 lg=2 xl=2>
                    <p class="mt-4" style="font-size:1rem;">ログイン</p>
                  </v-col>
                </v-row>
              </v-btn>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols=2 sm=2 md=1 lg=1 xl=1 />
            <v-col cols=3 sm=3 md=3 lg=2 xl=2 :class="[$vuetify.breakpoint.mdAndUp ? 'ml-n2 mt-n1' : 'ml-n10 mt-n1']">
              <div @click="makeAccount()" class="'caption'" style="font-size:0.7rem; font-weight:bold; color:#6c757d; cursor: pointer;">アカウント作成</div>
            </v-col>
            <v-col align="start" cols=4 sm=3 md=3 lg=4 xl=4 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-n1' : ' ml-n3 mt-n1']">
              <div @click="forgetPassword()" class="'caption'" style="font-size:0.7rem; font-weight:bold; color:#6c757d; cursor: pointer;">パスワードを忘れた</div>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
    </v-row>
    <v-row class="mt-8">
      <v-col cols=12 md=12></v-col>
    </v-row>
    <v-snackbar top v-model="snackbar" color="pink" elevation=12>
      {{ text }}
      <template v-slot:action="{ attrs }">
        <v-btn color="white" text v-bind="attrs" @click="snackbar = false">
          閉じる
        </v-btn>
      </template>
    </v-snackbar>
  </div>
</template>

<script>
  import {
    simpleAxios
  } from '../../backend/axios.js'
  const LOGIN_URL = '/api/v1/login'
  const USER_INFO_URL = '/api/v1/users/me'

  export default {
    name: 'Login',
    data() {
      return {
        email: '',
        password: '',
        error: '',
        snackbar: false,
        text: '',
        display_error_text: `Eメールとパスワードの組み合わせが違います。`,
        visible: true,
        sheetStyle:{
          border: '1px solid hsla(0,0%,100%,.1)',
          height: 'auto',
          width: 'auto',
        },
      }
    },
    created() {
      document.title = "VIDEOKIT"
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
        simpleAxios.defaults.headers.common['Authorization'] = `Bearer ${response.data.access_token}`
        simpleAxios.get(USER_INFO_URL, {
            params: {
              position: 'login'
            }
          })
          .then(me_response => {
            this.$store.commit('setCurrentUser', {
              currentUser: me_response.data,
              csrf: response.data.csrf,
              token: response.data.access_token
            })
            this.error = ''
            this.$router.replace('/')
          })
          .catch(error => this.signinFailed(error))
      },
      signinFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$store.commit('unsetCurrentUser')
        this.text = this.display_error_text
        this.snackbar = true
      },
      checkSignedIn() {
        if (this.$store.state.signedIn) {
          this.$router.replace('/')
        }
      },
      makeAccount(){
        this.$router.push({name: "signup"})
      },
      forgetPassword(){
        this.$router.push({name: "ForgotPassword"})
      }
    }
  }
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat&family=Open+Sans:wght@400;700&display=swap');

  .form-signup {
    width: 70%;
    max-width: 500px;
    padding: 10% 15px;
    margin: 0 auto;
  }

  h3 {
    font-size: 0.9rem;
  }

  .text-h4 {
    font-family: 'Open Sans', sans-serif;
    font-weight: 'bold';
  }
</style>