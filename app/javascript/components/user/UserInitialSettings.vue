<template>
  <div justify="center" align="center">
    <v-sheet
      elevation=10
      class="name rounded-lg ml-5 mt-16 mb-16"
      color="#212529"
      width="700"
      style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 600px; max-width: 100%; max-height:2000px;">
      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3 class="mt-7">
          <h3>ユーザーネーム</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-4">
          <base-text-field
            :childValue="user.username"
            v-on:input="user.username = $event"
          />
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=12 md=2 />
        <v-col cols=12 md=7 class="mt-n11 ml-9">
          <div>サービスで使用するユーザーネームを入力</div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3>
          <h3>アイコン</h3>
        </v-col>
        <v-col cols=12 md=2>
          <form enctype="multipart/form-data">
            <input type="file" ref="inputFile" @change="uploadFile()">
          </form>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-row>
        <v-col cols=12 md=4 />
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=12 md=4 />
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>

      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3 class="mt-1">
          <h3>自己紹介</h3>
        </v-col>
        <v-col cols=12 md=7 class=mt-n2>
          <base-text-field
            :childValue="user.about"
            v-on:input="user.about = $event"
          />
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=12 md=2 />
        <v-col cols=12 md=7 class="mt-n11 ml-2">
          <div>300字以内でプロフィールを入力</div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>

      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3 class="mt-1">
          <h3>居住地</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n2">
          <base-text-field
            :childValue="user.location"
            v-on:input="user.location = $event"
          />
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=12 md=4 />
        <v-col cols=12 md=7 class="mt-n11">
          <div></div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>

      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3 class="mt-1">
          <h3>Eメール</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <base-text-field
            :childValue="user.email"
            v-on:input="user.email = $event"
          />
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=12 md=2 />
        <v-col cols=12 md=7 class="mt-n11 ml-4">
          <div>サービスで使用するEメールを入力</div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>

      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3 class="mt-1">
          <h3>Youtube URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <base-text-field
            :childValue="user.youtube_url"
            v-on:input="user.youtube_url = $event"
          />
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=12 md=4 />
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>

      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3 class="mt-1">
          <h3>Facebook URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <base-text-field
            :childValue="user.facebook_url"
            v-on:input="user.facebook_url = $event"
          />
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=12 md=4 />
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>

      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3 class="mt-1">
          <h3>Instagram URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <base-text-field
            :childValue="user.instagram_url"
            v-on:input="user.instagram_url = $event"
          />
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>
      <v-divider />
      <v-row>
        <v-col cols=12 md=4 />
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>

      <v-row>
        <v-col cols=12 md=1 />
        <v-col cols=12 md=3 class="mt-1">
          <h3>Filmarks URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <base-text-field
            :childValue="user.filmarks_url"
            v-on:input="user.filmarks_url = $event"
          />
        </v-col>
        <v-col cols=12 md=1 />
      </v-row>

      <v-row>
        <v-col cols=12 md=10 class="mt-n16" />
        <v-col cols=12 md=2 class="ml-n11 mt-n7">
          <v-btn
            @click="saveProfile()"
            style="background-color:#2d00f7; font-weight:bold;"
            dark
            class="rounded-lg">
            保存
          </v-btn>
        </v-col>
      </v-row>
    </v-sheet>
  </div>
</template>

<script>
  import { secureAxios } from '../../backend/axios.js'
  import BaseTextField from '../base/BaseTextField';
  const USER_URL = '/api/v1/users/'

  export default {
    name: 'InitialSettings',
    data() {
      return {
        user: '',
        picture: ''
      }
    },
    components: {
      'base-text-field': BaseTextField
    },
    created() {
      this.user = this.$store.state.currentUser.data.attributes
    },
    methods: {
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
          avatar: this.picture
        })
          .then(response => this.updateSuccessful(response))
          .catch(error => this.Failed(error))
      },
      updateSuccessful(response) {
        this.$store.commit('setCurrentUser',
          {
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