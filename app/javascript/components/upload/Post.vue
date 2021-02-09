<template>
  <div justify="center" align="center">
    <v-row class="mt-14">
      <v-col cols=12 md=1 />
      <v-col cols=12 md=4 class=ml-n10>
        <h2>イベントを作ろう</h2>
      </v-col>
    </v-row>
    <v-sheet
      style="border: 1px solid hsla(0,0%,100%,.1);"
      color="#212529"
      height="510"
      class="rounded mt-3"
      width="950">
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>イベント名</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=8 class="mt-1">
          <base-text-field
            :childValue="title"
            v-on:input="title = $event"
          />
        </v-col>
      </v-row>
      <v-divider class="mt-n5"/>
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>開始時間</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-text-field
            v-model="start_date"
            type="datetime-local"
            outlined
            dark
            filled
            dense/>
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>終了時間</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-text-field
            v-model="end_date"
            type="datetime-local"
            outlined
            dark
            filled
            dense />
        </v-col>
      </v-row>
      <v-divider class="mt-n5"/>
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>参加人数</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <base-selector
            :selectorText="limitText"
            :childItems="numbers"
            v-on:select="limit = $event"
           />
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>使用ツール</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <v-select
            v-model="selected_tools"
            placeholder="使用ツールを選択"
            dense
            :items="tools"
            filled
            outlined
            multiple
            persistent-hint
          />
          <!-- <base-selector
            :selectorText="toolText"
            :childItems="tools"
            v-on:select="selected_tools = $event"
           /> -->
        </v-col>
      </v-row>
      <v-divider class="mt-n5"/>
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>カテゴリー</h3>
          <div style="color:#ff006e; font-size:0.6rem;">（※必須）</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <base-selector
            :selectorText="categoryText"
            :childItems="categories"
            v-on:select="selectedCategory = $event"
           />
        </v-col>
        <v-col cols=12 md=2 class="mt-4">
          <h3>タグ</h3>
          <div style="color:#ff006e; font-size:0.4rem;">（例）映画,ドラマ,Zoom</div>
        </v-col>
        <v-col cols=12 md=3 class="mt-1">
          <base-text-field
            :childValue="tagText"
            v-on:input="tag_list = $event"
          />
        </v-col>
      </v-row>
      <v-divider class="mt-n5"/>
      <v-row>
        <v-col cols=12 md=3 class="mt-4">
          <h3>イベント内容</h3>
        </v-col>
        <v-col cols=12 md=8 class="mt-5">
          <base-text-area
            :childValue="areaText"
            v-on:input="content = $event"
           />
        </v-col>
      </v-row>
    </v-sheet>
    <v-row class="mt-4">
      <v-col cols=12 md=2 />
      <v-col cols=12 md=1>
        <v-btn
          width="100"
          @click="postUrl()"
          style="background-color:#2d00f7; font-weight:bold;"
          large
          dark
          class="rounded">
          アップロード
        </v-btn>
      </v-col>
      <v-col cols=12 md=1>
        <v-btn
          width="100"
          @click="backTop()"
          style="background-color:#6c757d; color:#000000; font-weight:bold;"
          large
          dark
          class="rounded">
          キャンセル
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="mt-8">
      <v-col cols=12 md=12 />
    </v-row>
    <base-snackbar
     v-if="this.snackbar === true"
     :childValue="display_error_text"
     v-on:click="snackbar = value"
    />
  </div>
</template>

<script>
  import { secureAxios } from '../../backend/axios.js';
  import BaseTextField from '../../components/base/BaseTextField';
  import BaseTextArea from '../../components/base/BaseTextArea';
  import BaseSelector from '../../components/base/BaseSelector';
  import BaseSnackbar from '../../components/base/BaseSnackbar';
  const  POST_URL = '/api/v1/posts';

  export default {
    name: "Post",
    components: {
      'base-text-field': BaseTextField,
      'base-text-area':  BaseTextArea,
      'base-selector':   BaseSelector,
      'base-snackbar':   BaseSnackbar
    },
    data() {
      return {
        title: '',
        start_date: '',
        end_date: '',
        content: '',
        selectedCategory: '',
        tag_list: '',
        rule: '',
        limit: '',
        error: '',
        value: Boolean,
        snackbar: false,
        display_error_text: [],
        selected_tools: [],
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
        categories: [
          { id: 1, name: "Movie" },
          { id: 2, name: "TV" },
          { id: 3, name: "Zoom chat" },
          { id: 4, name: "Comedy" },
          { id: 5, name: "Free" },
          { id: 6, name: "Offline" },
        ],
        numbers: [
          1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
          11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
          "No limit"
        ],
      }
    },
    created(){
       this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      setError(error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      setCategory(){
        let category = this.categories.filter(category => category.name === this.selectedCategory)
        if (category.length > 0) {
          return category[0].id
        } else {
          return 1
        }
      },
      postUrl() {
        secureAxios.post(POST_URL, {
          title: this.title,
          category_id: this.setCategory(),
          content: this.content,
          tools: this.selected_tools,
          start_date: this.start_date,
          end_date: this.end_date,
          tag_list: this.tag_list
        })
        .then(response => {
          this.$router.replace('/')
        })
        .catch(error => this.Failed(error))
      },
      Failed(error){
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.display_error_text = this.ErrorChecker(this.error)
        this.snackbar = true
      },
      ErrorChecker(error){
        var i;
        let errors = []
        for(i = 0; i < error.length; i++){
          if (error[i] === `Title translation missing: ja.activerecord.errors.models.post.attributes.title.blank`){
            errors.push("タイトルが入力されていません。")
          } else if (error[i] === `Content translation missing: ja.activerecord.errors.models.post.attributes.content.blank`){
            errors.push("イベント内容が入力されていません。")
          } else if(error[i] === `Start date translation missing: ja.activerecord.errors.models.post.attributes.start_date.blank`){
            errors.push("開始時間が入力されていません。")
          } else if(error[i] === `End date translation missing: ja.activerecord.errors.models.post.attributes.end_date.blank`){
            errors.push("終了時間が入力されていません。")
          } else if(error[i] === `Tools translation missing: ja.activerecord.errors.models.post.attributes.tools.blank`){
            errors.push("使用ツールが入力されていません。")
          }
        }
        return errors
      },
      backTop(){
        this.$router.replace('/')
      }
    }
  }
</script>