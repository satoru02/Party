<template>
  <div justify="center" align="center">
    <v-row style="height:150;">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=10 lg=6 xl=6>
        <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1); width:auto; height:auto;" color="#212529"
          class="rounded-lg mt-6">
          <v-row>
            <v-col cols=12 md=2 lg=1 />
            <v-col cols=12 md=8 lg=10 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-8' : 'mt-0']">
              <div style="font-weight:bold;" class='text-h5'>アカウント作成</div>
            </v-col>
          </v-row>

          <v-row class="mt-4">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="email" outlined filled dense placeholder="Eメール" />
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>

          <v-row class="mt-n6">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="password" @click="visible = false" :type="visible ? 'text' : 'password'" outlined
                dark filled dense placeholder="パスワード" />
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>

          <v-row class="mt-n6">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="password_confirmation" @click="visible = false"
                :type="visible ? 'text' : 'password'" outlined dark filled dense placeholder="パスワードの確認" />
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>

          <v-row class="mt-n5">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="signup()" large depressed block color="#2d00f7">
                <v-row>
                  <v-col cols=5 sm=5 md=5 lg=5 xl=5 />
                  <v-col cols=2 sm=2 md=2 lg=2 xl=2>
                    <p class="mt-4" style="font-size:1rem;">登録</p>
                  </v-col>
                </v-row>
              </v-btn>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>

          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=6 sm=6 md=4 lg=4 xl=4 :class="[$vuetify.breakpoint.mdAndUp ? 'ml-n7 mt-n1' : 'ml-n4 mt-n1']">
              <router-link :to="{name: 'login'}">
                <p style="font-size:0.7rem; color:#6c757d;">アカウントを作成した事がある</p>
              </router-link>
            </v-col>
          </v-row>

        </v-sheet>
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
    </v-row>
    <v-row class="mt-8">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-snackbar top v-model="snackbar" color="pink">
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
  const SIGNUP_URL = '/api/v1/signup'

  export default {
    name: 'Signup',
    data() {
      return {
        email: '',
        password: '',
        password_confirmation: '',
        error: '',
        visible: true,
        snackbar: false,
        text: '',
        email_error: `Email translation missing: ja.activerecord.errors.models.user.attributes.email.taken`,
        email_error_text: `入力されたメールアドレスは既に使用されています。`,
        password_error: `Password confirmation translation missing: ja.activerecord.errors.models.user.attributes.password_confirmation.confirmation`,
        password_error_text: `入力されたパスワードの組み合わせが違います。`,
        error_text: `入力内容に間違いがあります。`
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
        // console.log(response)
        this.$router.replace({
          name: "check",
          params: {
            email: this.email
          }
        })
      },
      signupFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$store.commit('unsetCurrentUser')
        if (this.error === this.email_error) {
          this.text = this.email_error_text
        } else if (this.error === this.password_error) {
          this.text = this.password_error_text
        } else {
          this.text = this.error_text
        }
        this.snackbar = true
      },
      checkSignedIn() {
        if (this.$store.state.signedIn) {
          this.$router.replace('/')
        }
      }
    }
  }
</script>

<style scoped>
  .form-signup {
    width: 70%;
    max-width: 500px;
    padding: 10% 15px;
    margin: 0 auto;
  }

  h3 {
    font-size: 0.9rem;
  }
</style>