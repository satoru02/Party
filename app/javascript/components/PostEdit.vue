<template>
  <div justify="center" align="center">
    <v-row class="mt-14">
      <v-col cols=12 md=1></v-col>
      <v-col cols=12 md=5 class=ml-n5>
        <h2>イベントカスタマイザー</h2>
      </v-col>
    </v-row>
    <v-sheet style="border: 1px solid hsla(0,0%,100%,.1);" color="#212529" height="510" class="rounded mt-3"
      width="850">
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>イベント名</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=8 class="mt-1">
          <v-text-field v-model="post.title" :placeholder="post.title" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>
      <v-divider class="mt-n5"></v-divider>

      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>開催日</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-text-field v-model="post.date" :placeholder="post.date" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>時間</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-text-field v-model="time" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>

      <v-divider class="mt-n5"></v-divider>
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>参加人数</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-select :items="numbers" :placeholder="post.limit" dense filled outlined v-model="limit"></v-select>
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>使用ツール</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-select dense :items="tools" :placeholder="post.tools" filled outlined multiple persistent-hint
            v-model="post.tools"></v-select>
        </v-col>
      </v-row>
      <v-divider class="mt-n5"></v-divider>

      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>カテゴリー</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-select :items="categories" dense filled outlined v-model="category"></v-select>
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>タグ</h3>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-text-field v-model="post.tag_list" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>
      <v-divider class="mt-n5"></v-divider>

      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>イベント内容</h3>
        </v-col>
        <v-col cols=12 md=8 class="mt-5">
          <v-textarea :placeholder="post.content" outlined filled label=""></v-textarea>
        </v-col>
      </v-row>

    </v-sheet>
    <v-row class="mt-4">
      <v-col cols=12 md=2></v-col>
      <v-col cols=12 md=1>
        <v-btn @click="updatePost()" style="background-color:#2d00f7; font-weight:bold;" large dark class="rounded ml-13">カスタマイズ</v-btn>
      </v-col>
      <v-col cols=12 md=1>
        <v-btn @click="backTop()" style="background-color:#6c757d; color:#000000; font-weight:bold;" large dark class="rounded ml-15">
          キャンセル</v-btn>
      </v-col>
    </v-row>
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

  const POST_EDIT_URL = '/api/v1/posts/'

  export default {
    name: "postEdit",
    data() {
      return {
        post: '',
        tools: [
          "Youtube",
          "Zoom",
          "KIT PARTY Chat",
          "LINE",
          "Twitter",
          "Free"
        ],
        numbers: [
          1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
          11, 12, 13, 14, 15, 16, 17, 18, 19, 20, "No limit"
        ],
        categories: [
          "シェアウォッチ",
          "プライベートタイムライン",
          "お笑い",
          "Netflix",
          "Amazon Prime"
        ],
      }
    },
    created() {
      this.checkSignedIn()
      this.checkUsersPost()
      this.getPost()
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      getPost() {
        secureAxios.get(POST_EDIT_URL + `${this.$route.params.id}` + `/edit`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        if (!response.data) {
          this.Failed(response)
          return
        }
        this.post = response.data.data.attributes
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      },
      updatePost() {
        // secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.patch(POST_EDIT_URL + `${this.$route.params.id}`, {
            title: this.post.title,
            category_id: 1,
            content: this.post.content,
            tools: this.post.tools,
            tag_list: this.post.tag_list
          })
          .then(response => this.updateSuccessdul(response))
          .catch(error => this.Failed(error))
      },
      destroyPost() {
        // secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.delete(POST_EDIT_URL + `${this.$route.params.id}`)
          .then(response => this.updateSuccessdul(response))
          .catch(error => this.Failed(error))
      },
      updateSuccessdul(response) {
        if (!response.data) {
          this.Failed(response)
          return
        }
        this.$router.replace('/')
      },
      checkUsersPost() {
        if (!(this.$store.state.signedIn && this.$store.getters.currentUserId)) {
          this.$router.replace('/')
        }
      },
      backTop(){
        this.$router.replace('/')
      }
    }
  }
</script>