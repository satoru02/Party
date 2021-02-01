<template>
  <div justify="center" align="center">
    <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1);" color="#212529" height="600" class="rounded-lg mt-16"
      width="650">
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=8 class="mt-8">
          <h1>アカウント作成</h1>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=2 class="ml-n4">
          <h3 style="color:#edf2f4;">Eメール</h3>
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
        <v-col cols=12 md=2 class="ml-n2">
          <h3 style="color:#edf2f4;">パスワード</h3>
        </v-col>
      </v-row>
      <v-row class="mt-n4">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-text-field v-model="password" @click="visible = false" :type="visible ? 'text' : 'password'" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>

      <v-row class="mt-n4">
        <v-col cols=12 md=5 class="ml-n4">
          <h3 style="color:#edf2f4;">パスワードの確認</h3>
        </v-col>
      </v-row>
      <v-row class="mt-n4">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-text-field v-model="password_confirmation" @click="visible = false" :type="visible ? 'text' : 'password'" outlined dark filled dense></v-text-field>
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
                <p class="mt-4" style="font-size:1rem;">登録</p>
              </v-col>
            </v-row>
          </v-btn>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=4 class="ml-n5 mt-n4">
          <router-link :to="{name: 'login'}">
            <p style="font-size:0.7rem; color:#6c757d;">アカウントを作成した事がある</p>
          </router-link>
        </v-col>
      </v-row>

    </v-sheet>
    <v-row class="mt-8">
      <v-col cols=12 md=12></v-col>
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
  } from './backend/axios.js'
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
        this.$router.replace({name: "check", params: {email: this.email}})
      },
      signupFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$store.commit('unsetCurrentUser')
        if (this.error === this.email_error) {
          this.text = this.email_error_text
        } else if(this.error === this.password_error) {
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

<style lang="css">
  .form-signup {
    width: 70%;
    max-width: 500px;
    padding: 10% 15px;
    margin: 0 auto;
  }
</style>