<template>
  <div justify="center" align="center">
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=10 lg=6 xl=6>
        <v-sheet elevation=10 class="name rounded-lg mt-10" color="#212529"
          style="border: 1px solid hsla(0,0%,100%,.1); height:auto; width:auto;">
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-7">
              <h3>ユーザーネーム</h3>
            </v-col>
            <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-4">
              <base-text-field :childValue="user.username" v-on:input="user.username = $event" />
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-divider />
          <v-row>
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 />
            <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n6 ml-9">
              <div></div>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=3 sm=3 md=3 lg=3 xl=3>
              <h3>アイコン</h3>
            </v-col>
            <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n2">
              <v-file-input dark dense outlined v-model="picture" @change="getPresignedURI()" />
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
              <h3>自己紹介</h3>
            </v-col>
            <v-col cols=7 sm=7 md=7 lg=7 xl=7 class=mt-n2>
              <base-text-field :childValue="user.about" v-on:input="user.about = $event" />
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-divider />
          <v-row>
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 />
            <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n11 ml-2">
              <div></div>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>

          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-1">
              <h3>居住地</h3>
            </v-col>
            <v-col cols=7 sm=7 md=7 lg=7 xl=7 class="mt-n2">
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
            <v-col cols=2 sm=2 md=3 lg=2 xl=2 />
            <v-col cols=7 sm=7 md=7 lg=10 xl=7 class="mt-n11">
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
            <v-col cols=10 sm=10 md=10 lg=10 xl=10 class="mt-n16" />
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 class="ml-n11 mt-n7">
              <v-btn @click="saveProfile()" style="background-color:#2d00f7; font-weight:bold;" dark class="rounded-lg">
                保存
              </v-btn>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />

    </v-row>
  </div>
</template>

<script>
  import {
    secureAxios, simpleAxios
  } from '../../backend/axios.js'
  import BaseTextField from '../base/BaseTextField';
  const USER_URL = '/api/v1/users/'
  const GET_PRESIGNED_URL = '/api/v1/avatar'

  export default {
    name: 'UserInitialSettings',
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
      this.user = this.$store.state.currentUser.data.attributes
    },
    methods: {
      getPresignedURI(){
        secureAxios.get(GET_PRESIGNED_URL + `/` + `presigned_url`, {
          params: {
            filename: this.picture.name,
            filetype: this.picture.type
          }
        }).then(response => {
          var formdata = new FormData()
          formdata.append("Content-Type", response.data.fields['Content-Type'])
          formdata.append("key", response.data.fields['key'])
          formdata.append("acl", response.data.fields['acl'])
          formdata.append("policy", response.data.fields['policy'])
          formdata.append("x-amz-algorithm", response.data.fields['x-amz-algorithm'])
          formdata.append("x-amz-credential", response.data.fields['x-amz-credential'])
          formdata.append("x-amz-date", response.data.fields['x-amz-date'])
          formdata.append("x-amz-meta-original-filename", response.data.fields['x-amz-meta-original-filename'])
          formdata.append("x-amz-signature", response.data.fields['x-amz-signature'])
          formdata.append("file", this.picture, "file.txt")

          simpleAxios.post(response.data.url, formdata, {
            headers: {
              'Content-Type': 'multipart/form-data'
            }
          })
            .then((response) => {
              console.log(response)
          })
      })},
      saveProfile() {
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
            file_name: this.picture.name
          })
          .then(response => this.updateSuccessful(response))
          .catch(error => this.Failed(error))
      },
      updateSuccessful(response) {
        this.$store.commit('setCurrentUser', {
          currentUser: response.data,
          csrf: this.$store.state.csrf,
          token: this.$store.state.token
        })
        this.$router.replace('/')
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      uploadFile() {
        this.picture = this.$refs.inputFile.files[0];
      }
    }
  }
</script>

<style scoped>
  h3 {
    font-size: 0.9rem;
  }
</style>