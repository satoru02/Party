<template>
  <v-responsive class="overflow-y-auto flex-grow-1 flex-shrink-0" style="max-width: 100%;">
    <v-sheet class="rounded-lg" color="#212529"
      style="border: 1px solid hsla(0,0%,100%,.1); height:auto; width:auto;">
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-7">
          <h3>ユーザーネーム</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-5">
          <base-text-field :childValue="user.username" v-on:input="user.username = $event" />
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n11">
          <div></div>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row class="mt-3">
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3>
          <h3>アイコン</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n2">
          <!-- <v-file-input dark dense outlined type="file" ref="inputFile" @change="uploadFile()" /> -->
          <!-- <v-file-input dark dense outlined v-on:input="picture = value" /> -->
          <v-file-input dark dense outlined v-model="picture" />
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-2">
          <h3>自己紹介</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 >
          <base-text-field :childValue="user.about" v-on:input="user.about = $event" />
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-divider />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n11">
          <div></div>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-2">
          <h3>居住地</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7>
          <base-text-field :childValue="user.location" v-on:input="user.location = $event" />
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n11">
          <div></div>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-1">
          <h3>Eメール</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n1">
          <base-text-field :childValue="user.email" v-on:input="user.email = $event" />
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n11">
          <div></div>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-1">
          <h3>Youtube URL</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n1">
          <base-text-field :childValue="user.youtube_url" v-on:input="user.youtube_url = $event" />
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-1">
          <h3>Facebook URL</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n1">
          <base-text-field :childValue="user.facebook_url" v-on:input="user.facebook_url = $event" />
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-1">
          <h3>Instagram URL</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n1">
          <base-text-field :childValue="user.instagram_url" v-on:input="user.instagram_url = $event" />
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=4 sm=4 md=4 lg=4 xl=4 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-1">
          <h3>Filmarks URL</h3>
        </v-col>
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n1">
          <base-text-field :childValue="user.filmarks_url" v-on:input="user.filmarks_url = $event" />
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      </v-row>
      <v-row>
        <v-col cols=8 sm=8 md=8 lg=9 xl=9 class="mt-n16" />
        <v-col cols=2 sm=2 md=3 lg=2 xl=2 class="mt-n7">
          <v-btn width="100" @click="saveProfile()" style="background-color:#2d00f7; font-weight:bold;" dark
            class="rounded">
            保存
          </v-btn>
        </v-col>
      </v-row>
    </v-sheet>
    <v-row>
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-sheet class="name rounded-lg" color="#212529"
      style="border: 1px solid hsla(0,0%,100%,.1); height:auto; width:auto;">
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=5 sm=5 md=3 lg=3 xl=3 class="ml-n2">
          <h3>アカウント消去</h3>
        </v-col>
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="ml-n2">
          下記項目を確認した上、アカウントの削除をお願いします。
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="ml-n2">
          ・アカウントを消去すると、投稿したデータは全て削除されます。
        </v-col>
      </v-row>
      <v-row class="mt-n6">
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="ml-n2">
          ・当サイトは、ユーザーから収集した情報を保存しません。
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=8 sm=8 md=8 lg=9 xl=9 />
        <v-col cols=3 sm=3 md=3 lg=3 xl=3>
          <v-btn @click="deleteAccount()" color="red" width="100" style="font-weight:bold;" dark class="rounded">
            アカウント消去
          </v-btn>
        </v-col>
      </v-row>
    </v-sheet>
  </v-responsive>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios.js'
  import BaseTextField from '../base/BaseTextField';
  import { DirectUpload } from "activestorage"
  const USER_URL = '/api/v1/users/'

  export default {
    name: 'UserSettings',
    data() {
      return {
        user: '',
        picture: null
      }
    },
    components: {
      'base-text-field': BaseTextField
    },
    created() {
      this.checkSignedIn()
      this.checkUser()
    },
    methods: {
      checkUser() {
        if (`${this.$store.state.currentUser.data.attributes.id}` !== `${this.$route.params.id}`) {
          this.$router.replace('/')
        }
      },
      checkSignedIn() {
        if (this.$store.state.checkSignedIn) {
          this.$router.replace('/')
        }
        this.user = this.$store.state.currentUser.data.attributes
      },
      saveProfile() {
        this.uploadExecuter()
        secureAxios.patch(USER_URL + `${this.$store.state.currentUser.data.attributes.id}`, {
            email: this.user.email,
            about: this.user.about,
            name: this.user.name,
            username: this.user.username,
            location: this.user.location,
            web_url: this.user.web_url,
            youtube_url: this.user.youtube_url,
            facebook_url: this.user.facebook_url,
            instagram_url: this.user.instagram_url,
            filmarks_url: this.user.filmarks_url,
            avatar: this.picture
          })
          .then(response => this.updateSuccessful(response))
          .catch(error => this.Failed(error))
      },
      uploadExecuter(){
        console.log(this.picture)
        const upload = new DirectUpload(this.picture, '/rails/active_storage/direct_uploads', true)
        console.log(upload)
        upload.create((error, blob) => {
          if(error){
            console.log(error)
          } else {
            console.log(blob)
          }
        })
      },
      updateSuccessful(response) {
        this.$store.commit('setCurrentUser', {
          currentUser: response.data,
          csrf: this.$store.state.csrf,
          token: this.$store.state.token
        })
        // #dialog
        this.$router.replace('/')
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      uploadFile() {
        this.picture = this.$refs.inputFile.files[0];
      },
      deleteAccount() {
        secureAxios.delete(USER_URL + `/` + `${this.$store.state.currentUser.data.attributes.id}`)
          .then(res => this.deleteSuccessful(res))
          .catch(error => this.setError(error, 'Cannot log out.'))
      },
      deleteSuccessful(res) {
        localStorage.removeItem('vuex')
        this.$store.commit('unsetCurrentUser')
        this.$router.replace('/')
      }
    }
  }
</script>

<style scoped>
  input {
    color: white;
    font-family: 'Open Sans', sans-serif;
    font-size: 20;
    font-weight: bold;
  }

  h3 {
    font-size: 0.9rem;
  }
</style>