<template>
  <div justify="center" align="center">
    <v-sheet elevation=10 class="name rounded-lg ml-5 mt-16 mb-16" color="#212529" width="700"
      style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 600px; max-width: 100%; max-height:2000px;">
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-7">
          <h3>ユーザーネーム</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-4">
          <v-text-field v-model="user.username" :placeholder="user.username" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=7 class="mt-n11 ml-9">
          <div>サービスで使用するユーザーネームを入力</div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3>
          <h3>アイコン</h3>
        </v-col>
        <v-col cols=12 md=2>
          <form enctype="multipart/form-data">
            <input type="file" ref="inputFile" @change="uploadFile()">
          </form>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>自己紹介</h3>
        </v-col>
        <v-col cols=12 md=7 class=mt-n2>
          <v-text-field v-model="user.about" :placeholder="user.about" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=7 class="mt-n11 ml-2">
          <div>300字以内でプロフィールを入力</div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>居住地</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n2">
          <v-text-field v-model="user.location" :placeholder="user.location" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n11">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Eメール</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.email" :placeholder="user.email" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=7 class="mt-n11 ml-4">
          <div>サービスで使用するEメールを入力</div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Youtube URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.youtube_url" :placeholder="user.youtube_url" outlined dark filled dense>
          </v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Facebook URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.facebook_url" :placeholder="user.facebook_url" outlined dark filled dense>
          </v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Instagram URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.instagram_url" :placeholder="user.instagram_url" outlined dark filled dense>
          </v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Filmarks URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.filmarks_url" :placeholder="user.filmarks_url" outlined dark filled dense>
          </v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=10 class="mt-n16"></v-col>
        <v-col cols=12 md=2 class="ml-n11 mt-n7">
          <v-btn @click="saveProfile()" style="background-color:#2d00f7; font-weight:bold;" dark class="rounded-lg">保存</v-btn>
        </v-col>
      </v-row>
    </v-sheet>
  </div>
</template>

<script>
  import { secureAxios } from '../../backend/axios.js'
  const USER_URL = '/api/v1/users/'

  export default {
    name: 'InitialSettings',
    data() {
      return {
        user: '',
        picture: ''
      }
    },
    created() {
      this.user = this.$store.state.currentUser.data.attributes
    },
    methods: {
      saveProfile() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf

        // const params = {
        //   email: this.user.email,
        //   about: this.user.about,
        //   name: this.user.name,
        //   username: this.user.username,
        //   location: this.user.location,
        //   web_url: this.user.web_url,
        //   youtube_url: this.user.youtube_url,
        //   facebook_url: this.user.facebook_url,
        //   instagram_url: this.user.instagram_url,
        //   filmarks_url: this.user.filmarks_url,
        //   avatar: this.picture
        // }
        // let formData = new FormData()
        // Object.entries(params).forEach(
        //   ([key, value]) => formData.append(key, value)
        // )

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
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      updateSuccessful(response) {
        this.$router.replace('/')
      },
      uploadFile() {
        this.picture = this.$refs.inputFile.files[0];
      }
    }
  }
</script>