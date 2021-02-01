<template>
  <div justify="center" align="center">
    <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1);" color="#212529" height="450"
      class="rounded-lg mt-16" width="650">
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=8 class="mt-8">
          <h1>パスワードの再設定</h1>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=2 class="ml-n2">
          <h3 style="color:#edf2f4;">パスワード</h3>
        </v-col>
      </v-row>
      <v-row class="mt-n4">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-text-field v-model="password" outlined filled dense></v-text-field>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="ml-n4">
          <h3 style="color:#edf2f4;">パスワードの確認</h3>
        </v-col>
      </v-row>
      <v-row class="mt-n4">
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-text-field v-model="password_confirmation" outlined filled dense></v-text-field>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-btn @click="resetPassword()" large depressed block color="#2d00f7">
            <v-row>
              <v-col cols=12 md=4></v-col>
              <v-col cols=12 md=1>
                <p class="mt-4 ml-10" style="font-size:1rem;">再設定</p>
              </v-col>
            </v-row>
          </v-btn>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=2 class="mt-n4 ml-n5">
          <router-link :to="{name: 'login'}">
            <p style="font-size:0.7rem; color:#6c757d;">ログイン</p>
          </router-link>
        </v-col>
        <v-col cols=12 md=2 class="mt-n4 ml-n8">
          <router-link :to="{name: 'signup'}">
            <p style="font-size:0.7rem; color:#6c757d;">アカウント登録</p>
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
    simpleAxios,
    secureAxios
  } from '../backend/axios.js'
  const PASSWORD_RESET_URL = '/api/v1/password_resets'

  export default {
    name: 'ResetPassword',
    data() {
      return {
        password: '',
        password_confirmation: '',
        error: '',
        notice: ''
      }
    },
    created() {
      this.checkPasswordToken()
    },
    methods: {
      resetPassword() {
        secureAxios.patch(PASSWORD_RESET_URL + `/` + `${this.$route.params.token}`, {
            password: this.password,
            password_confirmation: this.password_confirmation
          })
          .then(response => this.resetSuccessful(response))
          .catch(error => this.resetFailed(error))
      },
      resetSuccessful(response) {
        this.notice = 'Your password has been reset.'
        this.error = ''
        this.password = ''
        this.password_confirmation = ''
        this.$router.replace('/')
      },
      resetFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
        this.notice = ''
      },
      checkPasswordToken() {
        simpleAxios.get(PASSWORD_RESET_URL + `/` + `${this.$route.params.token}`)
          .catch(error => {
            this.resetFailed(error)
            this.$router.replace('/')
          })
      }
    }
  }
</script>