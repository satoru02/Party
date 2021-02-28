<template>
  <div justify="center" align="center">
    <v-row class="hidden-xs-only">
      <v-col cols=12 sm=11 md=1 lg=1 xl=1 />
      <v-col sm=11 md=4 lg=4 xl=4>
        <div :class="[$vuetify.breakpoint.mdAndUp ? 'text-h5 ml-n3 mt-5' : 'hidden-xs-only']">イベントを作ろう</div>
      </v-col>
    </v-row>
    <v-row>
      <v-col xs=1 sm=1 md=1 lg=2 xl=2 />
      <v-col cols=10 sm=10 md=10 lg=8 xl=8>
        <v-sheet style="border: 1px solid hsla(0,0%,100%,.1); height:auto; width:auto;" color="#212529" height="510"
          class="rounded mt-3">
          <v-row>
            <v-col cols=4 sm=12 md=3 lg=3 xl=3 class="mt-3">
              <h3>イベント名</h3>
              <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
            </v-col>
            <v-col cols=7 sm=12 md=8 lg=8 xl=8 class="mt-1">
              <base-text-field :childValue="post.title" v-on:input="post.title = $event" />
            </v-col>
          </v-row>
          <v-divider class="mt-n5 hidden-xs-only hidden-sm-only" />
          <v-row>
            <v-col cols=4 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-3' : 'mt-n6']">
              <h3>開始時間</h3>
              <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
            </v-col>
            <v-col cols=7 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1' : 'mt-n9']">
              <v-text-field v-model="start_date" type="datetime-local" outlined dark filled dense />
            </v-col>
            <v-col cols=4 sm=12 md=2 lg=2 xl=2 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-3' : 'mt-n6']">
              <h3>終了時間</h3>
              <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
            </v-col>
            <v-col cols=7 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1' : 'mt-n9']">
              <v-text-field v-model="end_date" type="datetime-local" outlined dark filled dense />
            </v-col>
          </v-row>
          <v-divider class="mt-n5 hidden-xs-only hidden-sm-only" />
          <v-row>
            <v-col cols=4 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-3' : 'mt-n6']">
              <h3>参加人数</h3>
              <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
            </v-col>
            <v-col cols=7 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1' : 'mt-n9']">
              <base-selector :selectorText="limitText" :childItems="numbers" v-on:select="limit = $event" />
            </v-col>
            <v-col cols=4 sm=12 md=2 lg=2 xl=2 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-3' : 'mt-n6']">
              <h3>使用ツール</h3>
              <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
            </v-col>
            <v-col cols=7 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1' : 'mt-n9']">
              <v-select v-model="post.tools" placeholder="使用ツールを選択" dense :items="tools" filled outlined multiple
                persistent-hint />
              <!-- <base-selector
            :selectorText="toolText"
            :childItems="tools"
            v-on:select="selected_tools = $event"
           /> -->
            </v-col>
          </v-row>
          <v-divider class="mt-n5 hidden-xs-only hidden-sm-only" />
          <v-row>
            <v-col cols=4 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-3' : 'mt-n6']">
              <h3>カテゴリー</h3>
              <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
            </v-col>
            <v-col cols=7 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1' : 'mt-n9']">
              <base-selector :selectorText="categoryText" :childItems="categories"
                v-on:select="selectedCategory = $event" />
            </v-col>
            <v-col cols=4 sm=12 md=2 lg=2 xl=2 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-3' : 'mt-n6']">
              <h3>タグ</h3>
              <div style="color:#ff006e; font-size:0.4rem;">（例）映画,ドラマ,Zoom</div>
            </v-col>
            <v-col cols=7 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1' : 'mt-n9']">
              <base-text-field :childValue="tagText" v-on:input="tag_list = $event" />
            </v-col>
          </v-row>
          <v-divider class="mt-n5 hidden-xs-only hidden-sm-only" />
          <v-row>
            <v-col cols=4 sm=12 md=3 lg=3 xl=3 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-3' : 'mt-n6']">
              <h3>イベント内容</h3>
            </v-col>
            <v-col cols=7 sm=12 md=8 lg=8 xl=8 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-3' : 'mt-n9']">
              <base-text-area :childValue="post.content" v-on:input="post.content = $event" />
            </v-col>
          </v-row>
          <v-row class="hidden-md-only hidden-sm-only hidden-lg-only hidden-xl-only mt-n8">
            <v-col cols=1 />
            <v-col cols=9>
              <v-btn width="330" @click="updatePost()" style="background-color:#2d00f7; font-weight:bold;" dark class="rounded">
                告知
              </v-btn>
            </v-col>
          </v-row>
        </v-sheet>
        <base-snackbar v-if="this.snackbar === true" :childValue="display_error_text" v-on:click="snackbar = value" />
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=2 xl=2 />
    </v-row>
    <v-row>
      <v-col sm=12 md=2 lg=2 xl=2 />
      <v-col cols=1 sm=1 class="hidden-md-only hidden-lg-only hidden-xl-only" />
      <v-col cols=3 sm=2 md=2 lg=1 xl=1>
        <v-btn width="100" @click="updatePost()" style="background-color:#2d00f7; font-weight:bold;" large dark
          class="rounded">
          告知
        </v-btn>
      </v-col>
      <v-col cols=3 sm=2 md=2 lg=1 xl=1>
        <v-btn width="100" @click="backTop()" style="background-color:#6c757d; color:#000000; font-weight:bold;" large
          dark class="rounded">
          キャンセル
        </v-btn>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios.js';
  import BaseTextField from '../../components/base/BaseTextField';
  import BaseTextArea from '../../components/base/BaseTextArea';
  import BaseSelector from '../../components/base/BaseSelector';
  import BaseSnackbar from '../../components/base/BaseSnackbar';
  const POST_EDIT_URL = '/api/v1/posts/';

  export default {
    name: "PostEdit",
    components: {
      'base-text-field': BaseTextField,
      'base-text-area': BaseTextArea,
      'base-selector': BaseSelector,
      'base-snackbar': BaseSnackbar
    },
    data() {
      return {
        start_date: '',
        end_date: '',
        post: '',
        limit: '',
        selectedCategory: '',
        value: Boolean,
        snackbar: false,
        display_error_text: [],
        limitText: "参加人数を選択",
        toolText: "使用ツールを選択",
        categoryText: "カテゴリーを選択",
        tagText: "タグを入力",
        areaText: "イベントの内容を入力",
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
        categories: [{
            id: 1,
            name: "Movie"
          },
          {
            id: 2,
            name: "TV"
          },
          {
            id: 3,
            name: "Zoom chat"
          },
          {
            id: 4,
            name: "Comedy"
          },
          {
            id: 5,
            name: "Free"
          },
          {
            id: 6,
            name: "Offline"
          },
        ],
      }
    },
    created() {
      document.title = "編集 - PartyKit"
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
      setCategory() {
        var category = this.categories.filter(category => category.name === this.post.Category)
        if (category.length > 0) {
          return category[0].id
        } else {
          return 1
        }
      },
      updatePost() {
        secureAxios.patch(POST_EDIT_URL + `${this.$route.params.id}`, {
            title: this.post.title,
            category_id: this.setCategory(),
            content: this.post.content,
            tools: this.post.tools,
            start_date: this.start_date,
            end_date: this.end_date,
            tag_list: this.post.tag_list
          })
          .then(response => this.updateSuccessful(response))
          .catch(error => this.updateFailed(error))
      },
      updateSuccessful(response) {
        if (!response) {
          this.Failed(response)
          return
        }
        this.$router.replace('/')
      },
      updateFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.display_error_text = this.ErrorChecker(this.error)
        this.snackbar = true
      },
      ErrorChecker(error) {
        var i;
        let errors = []
        for (i = 0; i < error.length; i++) {
          if (error[i] === `Title translation missing: ja.activerecord.errors.models.post.attributes.title.blank`) {
            errors.push("タイトルが入力されていません。")
          } else if (error[i] ===
            `Content translation missing: ja.activerecord.errors.models.post.attributes.content.blank`) {
            errors.push("イベント内容が入力されていません。")
          } else if (error[i] ===
            `Start date translation missing: ja.activerecord.errors.models.post.attributes.start_date.blank`) {
            errors.push("開始時間が入力されていません。")
          } else if (error[i] ===
            `End date translation missing: ja.activerecord.errors.models.post.attributes.end_date.blank`) {
            errors.push("終了時間が入力されていません。")
          } else if (error[i] ===
            `Tools translation missing: ja.activerecord.errors.models.post.attributes.tools.blank`) {
            errors.push("使用ツールが入力されていません。")
          }
        }
        return errors
      },
      destroyPost() {
        secureAxios.delete(POST_EDIT_URL + `${this.$route.params.id}`)
          .then(response => this.updateSuccessdul(response))
          .catch(error => this.Failed(error))
      },
      checkUsersPost() {
        if (!(this.$store.state.signedIn && this.$store.getters.currentUserId)) {
          this.$router.replace('/')
        }
      },
      backTop() {
        this.$router.replace('/')
      }
    }
  }
</script>

<style scoped>
  h3 {
    font-size: 0.9rem;
  }
</style>