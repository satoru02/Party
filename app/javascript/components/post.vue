<template>
  <div justify="center" align="center">
    <v-row class="mt-14">
      <v-col cols=12 md=1></v-col>
      <v-col cols=12 md=5 class=ml-n10>
        <h2>イベントを作ろう</h2>
      </v-col>
    </v-row>
    <v-sheet style="border: 1px solid hsla(0,0%,100%,.1);" color="#212529" height="510" class="rounded mt-3"
      width="850">
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>イベント名</h3>
        </v-col>
        <v-col cols=12 md=8 class="mt-1">
          <v-text-field v-model="title" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>
      <v-divider class="mt-n5"></v-divider>

      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>開催日</h3>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-text-field v-model="date" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>時間</h3>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-text-field v-model="time" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>

      <v-divider class="mt-n5"></v-divider>
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>参加人数</h3>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-select :items="numbers" dense filled outlined v-model="limit"></v-select>
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>使用ツール</h3>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-select dense :items="tools" filled outlined multiple persistent-hint v-model="tool"></v-select>
        </v-col>
      </v-row>
      <v-divider class="mt-n5"></v-divider>

      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>カテゴリー</h3>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-select :items="categories" dense filled outlined v-model="category"></v-select>
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>タグ</h3>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-text-field v-model="tag_list" outlined dark filled dense></v-text-field>
        </v-col>
      </v-row>
      <v-divider class="mt-n5"></v-divider>

      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>イベント内容</h3>
        </v-col>
        <v-col cols=12 md=8 class="mt-5">
          <v-textarea outlined filled label=""></v-textarea>
        </v-col>
      </v-row>

    </v-sheet>
    <v-row class="mt-4">
      <v-col cols=12 md=2></v-col>
      <v-col cols=12 md=1>
        <v-btn style="background-color:#2d00f7; font-weight:bold;" large dark class="rounded ml-13">アップロード</v-btn>
      </v-col>
      <v-col cols=12 md=1>
        <v-btn style="background-color:#6c757d; color:#000000; font-weight:bold;" large dark class="rounded ml-15">
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
    secureAxios
  } from '../backend/axios.js'
  const POST_URL = '/api/v1/posts'

  export default {
    name: "post",
    data() {
      return {
        title: '',
        date: '',
        time: '',
        content: '',
        category: '',
        categories: [
          "シェアウォッチ",
          "プライベートタイムライン",
          "お笑い",
          "Netflix",
          "Amazon Prime"
        ],
        limit: '',
        numbers: [
          1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
          11, 12, 13, 14, 15, 16, 17, 18, 19, 20, "No limit"
        ],
        tool: '',
        tools: [
          "Youtube",
          "Zoom",
          "KIT PARTY Chat",
          "LINE",
          "Twitter",
          "Free"
        ],
        tag_list: '',
        rule: ''
      }
    },
    methods: {
      setError(error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      postUrl(title, content, tag_list) {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(POST_URL, {
            title: title,
            category_id: 1,
            content: content,
            tag_list: tag_list
          })
          .then(response => {
            this.$router.replace('/')
          })
          .catch(error => this.setError(error, "Cannot post"))
      }
    }
  }
</script>