<template>
  <div justify="center" align="center">
    <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1);" color="#212529" height="330"
      class="rounded-lg mt-16" width="650">
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=8 class="mt-8">
          <h1>パスワードをリセットする</h1>
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

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=10>
          <v-btn @click="resetPassword()" large depressed block color="#2d00f7">
            <v-row>
              <v-col cols=12 md=4></v-col>
              <v-col cols=12 md=1>
                <p class="mt-4 ml-1" style="font-size:1rem;">Eメールを送信する</p>
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
        <v-col cols=12 md=2 class="mt-n4 ml-n10">
          <router-link :to="{name: 'signup'}">
            <p style="font-size:0.7rem; color:#6c757d;">アカウント登録</p>
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
  import { secureAxios } from '../../backend/axios.js'
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