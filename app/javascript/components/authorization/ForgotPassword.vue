<template>
  <div justify="center" align="center">
    <v-row style="height:110;">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=10 lg=6 xl=6>
        <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1); width:auto; height:auto" color="#212529"
          class="rounded-lg mt-16">
          <v-row>
            <v-col sm=2 md=2 lg=2 xl=2 class="hidden-xs-only" />
            <v-col cols=12 sm=8 md=8 lg=8 xl=8 class="mt-8">
              <div style="font-weight:bold;" class='text-h5'>パスワードをリセットする</div>
            </v-col>
          </v-row>

          <v-row class="mt-4">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="email" outlined filled dense placeholder="Eメール" />
            </v-col>
          </v-row>

          <v-row>
            <v-col cols=1 m=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="resetPassword()" large depressed block color="#2d00f7">
                <v-row>
                  <v-col cols=3 sm=4 md=4 lg=4 xl=4 />
                  <v-col cols=1 sm=1 md=1 lg=1 xl=1>
                    <p class="mt-4" style="font-size:1rem;">Eメールを送信する</p>
                  </v-col>
                </v-row>
              </v-btn>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=3 sm=2 md=2 lg=2 xl=2 class="mt-n1 ml-n5">
              <router-link :to="{name: 'login'}">
                <p style="font-size:0.7rem; color:#6c757d;">ログイン</p>
              </router-link>
            </v-col>
            <v-col cols=3 sm=2 md=2 lg=2 xl=2 class="mt-n1 ml-n10">
              <router-link :to="{name: 'signup'}">
                <p style="font-size:0.7rem; color:#6c757d;">アカウント登録</p>
              </router-link>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
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
    secureAxios
  } from '../../backend/axios.js'
  const PASSWORD_RESET_URL = '/api/v1/password_resets';

  export default {
    name: "ForgotPassword",
    data() {
      return {
        email: '',
        error: '',
        notice: '',
        snackbar: false,
        text: '',
        display_error_text: `入力されたEメールで登録されたユーザーは存在しません。`,
      }
    },
    created(){
      document.title = "PartyKit - オンラインイベント告知サービス"
    },
    methods: {
      resetPassword() {
        secureAxios.post(PASSWORD_RESET_URL, {
            email: this.email
          })
          .then(() => this.submitSuccessful())
          .catch(error => this.submitFailed(error))
      },
      submitSuccessful() {
        this.notice = 'Email with reset password istructions had been sent.'
        this.error = ''
        this.$router.replace({
          name: "check",
          params: {
            email: this.email
          }
        })
      },
      submitFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ''
        this.text = this.display_error_text
        this.snackbar = true
      }
    }
  }
</script>

<style scoped>
  h3 {
    font-size: 0.9rem;
  }
</style>