<template>
  <div justify="center" align="center">
    <v-row>
      <v-col cols=1 sm=1 md=3 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=6 lg=6 xl=6>
        <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1); height:auto; width:auto;" color="#212529"
          class="rounded-lg mt-16">
          <v-row>
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 />
            <v-col cols=8 sm=8 md=8 lg=8 xl=8 class="mt-8">
              <h2>パスワードの再設定</h2>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=3 sm=2 md=3 lg=2 xl=2 class="ml-n2">
              <h3 style="color:#edf2f4;">パスワード</h3>
            </v-col>
          </v-row>
          <v-row class="mt-n4">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="password" outlined filled dense />
            </v-col>
          </v-row>

          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=4 sm=3 md=4 lg=3 xl=3 class="ml-n4">
              <h3 style="color:#edf2f4;">パスワードの確認</h3>
            </v-col>
          </v-row>

          <v-row class="mt-n4">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="password_confirmation" outlined filled dense />
            </v-col>
          </v-row>

          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="resetPassword()" large depressed block color="#2d00f7">
                <v-row>
                  <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
                  <v-col cols=1 sm=1 md=1 lg=1 xl=1>
                    <p class="mt-4 ml-10" style="font-size:1rem;">再設定</p>
                  </v-col>
                </v-row>
              </v-btn>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=3 sm=2 md=2 lg=2 xl=2 class="mt-n4 ml-n5">
              <router-link :to="{name: 'login'}">
                <p style="font-size:0.7rem; color:#6c757d;">ログイン</p>
              </router-link>
            </v-col>
            <v-col cols=3 sm=2 md=2 lg=2 xl=2 class="mt-n4 ml-n8">
              <router-link :to="{name: 'signup'}">
                <p style="font-size:0.7rem; color:#6c757d;">アカウント登録</p>
              </router-link>
            </v-col>
          </v-row>

        </v-sheet>
      </v-col>
      <v-col cols=1 sm=1 md=3 lg=3 xl=3 />
    </v-row>
  </div>
</template>

<script>
  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios.js'
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
      document.title = "Reset Password | PartyKit - オンラインイベント告知サービス"
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

<style scoped>
  h3 {
    font-size: 0.9rem;
  }
</style>