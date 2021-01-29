<template>
  <div infinite-wrapper>
    <v-container>
      <v-row no-gutters>
        <v-col v-for="post in posts" :key="post.attributes.id + Math.random()" :title="post.attributes.title"
          :user_id="post.attributes.user_id" class="mb-9 pr-7" cols="12" sm="16">
          <v-sheet class="rounded-lg" color="#11151c" width="740"
            style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 150px; max-width: 100%; max-height:1000px;">
            <v-row>
              <v-col cols=12 md=2 class="ml-7 mt-1" color="#efeff1">
                <v-btn small color="#2d00f7">イベント</v-btn>
              </v-col>
              <v-col cols=12 md=4 class="ml-n10 mt-2" color="#efeff1">
                <h3>{{ post.attributes.title }}</h3>
              </v-col>
              <v-col cols=12 md=2 class="mt-1" color="#efeff1">
                <v-btn small color="#2d00f7">開催日</v-btn>
              </v-col>
              <v-col cols=12 md=3 class="ml-n13 mt-2" color="#efeff1">
                <h3>{{ postTime(post.attributes.created_at) }}</h3>
              </v-col>
              <v-col cols=12 md=1 class="mt-2 ml-16"
                v-if="$store.state.currentUser.data.attributes.id === post.attributes.user_id">
                <v-menu left offset-y nudge-width="140" nudge-height="100" nudge-bottom="10">
                  <template v-slot:activator="{ on, attrs}">
                    <v-icon color="#edf6f9" v-bind="attrs" v-on="on">mdi-dots-horizontal</v-icon>
                  </template>
                  <v-list class="rounded-s" style="background-color:#343a40;">
                    <router-link :to="{ name: 'PostEdit', params: {id: `${post.attributes.id }`}}">
                      <v-list-item>
                        <v-list-item-title class="ml-5">編集する</v-list-item-title>
                      </v-list-item>
                    </router-link>
                    <v-list-item>
                      <router-link :to="{ name: 'PostEdit', params: {id: `${post.attributes.id }`}}">
                        <v-list-item-title class="ml-5">削除する</v-list-item-title>
                      </router-link>
                    </v-list-item>
                  </v-list>
                </v-menu>
              </v-col>
            </v-row>
            <v-divider></v-divider>
            <v-row>
              <v-col cols=12 md=11 class="ml-7 mt-3">
                <p style="color:#efeff1; font-size:0.8rem;">{{ post.attributes.content }}</p>
              </v-col>
              <v-col cols=12 md=1></v-col>
            </v-row>
            <v-row class="mt-n3">
              <v-col cols=12 md="3" class="ml-7 mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">
                  <v-icon small>mdi-account-multiple-outline</v-icon> 参加人数
                </p>
              </v-col>
              <v-col cols=12 md="3" class="mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">15人</p>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols=12 md="3" class="ml-7 mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">
                  <v-icon small>mdi-door-open</v-icon> カテゴリー
                </p>
              </v-col>
              <v-col cols=12 md="3" class="mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">{{ post.attributes.category.name }}</p>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols=12 md="3" class="ml-7 mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">
                  <v-icon small>mdi-laptop</v-icon> 使用ツール
                </p>
              </v-col>
              <v-col cols=12 md="5" class="mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">Zoom Youtube Twitch Twitter ChatRoom</p>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols=12 md="3" class="ml-7 mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">
                  <v-icon small>mdi-comment-outline</v-icon> 主催者からのコメント
                </p>
              </v-col>
              <v-col cols=12 md="6" class="mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">悪口禁止
                </p>
              </v-col>
            </v-row>
            <v-row class="tag mt-n5 ml-n9">
              <v-col cols=12 md=1></v-col>
              <div v-for="(n,index) in post.attributes.tag_list" :key="index">
                <v-col cols=12 md=1 class="ml-n4">
                  <v-btn depressed class="rounded-s" x-small color="#46494c">
                    {{ n }}
                  </v-btn>
                </v-col>
              </div>
              <v-col cols=12 md=8></v-col>
            </v-row>
            <v-row>
              <v-col cols=12 md=9></v-col>
              <v-col cols=12 md=3 class="ml-n5 mb-1"
                v-if="($store.state.currentUser.data.attributes.id !== post.attributes.user_id) && (post.attributes.can_request_entry === true)">
                <v-btn color="#e36414" @click="entryRequest(post), dialog = true">
                  <v-icon>mdi-hail</v-icon>
                  <h3 style="font-size: 0.7rem">イベントに申し込む</h3>
                </v-btn>
              </v-col>
              <v-col cols=12 md=2 class="mb-1"
                v-if="($store.state.currentUser.data.attributes.id !== post.attributes.user_id) && (post.attributes.can_request_entry === false)">
                <v-btn disabled>
                  <v-icon>mdi-hail</v-icon>
                  <h3 style="font-size: 0.7rem">申し込み済み</h3>
                </v-btn>
              </v-col>
            </v-row>
          </v-sheet>
        </v-col>
      </v-row>
    </v-container>
    <infinite-loading spinner="spiral" @infinite="infiniteHandler"></infinite-loading>
    <div class="dialog">
      <v-dialog light v-model="dialog" width="500">
        <v-card>
          <v-card-title>エントリー完了！</v-card-title>
          <v-card-text>エントリーが完了しました。オーガナイザーが承認すれば、イベントに参加出来ます。</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" text @click="dialog = false">
              Close
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
  </div>
</template>

<script>
  import {
    simpleAxios
  } from '../backend/axios.js'
  import Avatar from '../components/perpage/TheAvatar.vue';
  import InfiniteLoading from 'vue-infinite-loading';
  import moment from 'moment';

  const CONTENT_URL = '/api/v1/posts/search'

  export default {
    name: 'Search',
    components: {
      'avatar': Avatar,
      'infinite-loading': InfiniteLoading,
    },
    data() {
      return {
        page: 1,
        pageSize: 9,
        posts: [],
        dialog: false
      }
    },
    watch: {
      '$route.params': {
        immediate: true,
        handler() {
          this.initialize()
          this.infiniteHandler()
        }
      }
    },
    methods: {
      initialize() {
        this.page = 1
        this.posts = []
      },
       infiniteHandler($state) {
        simpleAxios.get(CONTENT_URL, {
          params: {
            page: this.page,
            per_page: this.pageSize,
            filter_category: 'title',
            q: this.$route.params.query,
          }
        })
          .then(res => setTimeout(() => {
            if (res.data.data.length) {
              this.page += 1;
              this.posts.push(...res.data.data);
              $state.loaded();
            } else {
              $state.complete();
            }
          }, 1000))
      },
      failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      },
      entryRequest(post) {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(ENTRY_URL, {
          post: post.id,
          user: post.user_id
        })
        post.can_request_entry = false
      },
      postTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      }
    }
  }
</script>