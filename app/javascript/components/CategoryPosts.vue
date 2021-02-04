<template>
  <div infinite-wrapper>
    <v-container>
      <v-row no-gutters>
        <v-col v-for="post in posts" :key="post.attributes.id + Math.random()" :title="post.attributes.title"
          :user_id="post.attributes.user_id" class="mb-9 pr-10" cols="12" sm="16">
          <v-sheet class="rounded-lg" color="#11151c" width="740"
            style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 150px; max-width: 100%; max-height:1000px;">
            <v-row>
              <v-col cols=12 md=2 class="mt-1 ml-2" align="center" color="#efeff1">
                <v-btn small color="#2d00f7">イベント</v-btn>
              </v-col>
              <v-col cols=12 md=9 class="mt-1" align="start" lg color="#ffffff">
                <h2>{{ post.attributes.title }}</h2>
              </v-col>
              <!-- <v-col cols=12 md=1 class="mt-2"
                v-if="$store.state.currentUser.data.attributes.id === post.attributes.user_id">
                <v-menu left offset-y nudge-width="140" nudge-height="100" nudge-bottom="10">
                  <template v-slot:activator="{ on, attrs}">
                    <v-icon color="#edf6f9" v-bind="attrs" v-on="on">mdi-dots-horizontal</v-icon>
                  </template>
                  <v-list class="rounded-s" style="background-color:#343a40;">
                    <router-link :to="{ name: 'PostEdit', params: {id: `${post.attributes.id }`}}">
                      <v-list-item class="tile">
                        <v-list-item-title class="ml-5">編集する</v-list-item-title>
                      </v-list-item>
                    </router-link>
                    <v-list-item @click="delete_check_dialog = true, delete_post = post.attributes.id" class="tile">
                      <v-list-item-title style="font-weight: bold" class="ml-5">削除する</v-list-item-title>
                    </v-list-item>
                  </v-list>
                </v-menu>
              </v-col> -->
            </v-row>
            <v-divider></v-divider>
            <v-row>
              <v-col cols=12 md=11 class="ml-7 mt-3">
                <p style="color:#efeff1; font-size:0.8rem;">{{ post.attributes.content }}</p>
              </v-col>
              <v-col cols=12 md=1></v-col>
            </v-row>
            <v-row class="mt-n3">
              <v-col cols=12 md="2" align="center" class="mt-n6 ml-3">
                <p style="color:#ced4da; font-size:0.8rem;">
                  <v-icon color="#ced4da" small>mdi-calendar-clock</v-icon> 開催日程
                </p>
              </v-col>
              <v-col cols=12 md="5" align="start" class="mt-n6">
                <p style="color:#ced4da; font-size:0.8rem;">{{ startTime(post) }} 〜 {{ endTime(post) }}</p>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols=12 md="2" align="center" class="mt-n6 ml-3">
                <p style="color:#ced4da; font-size:0.8rem;">
                  <v-icon color="#ced4da" small>mdi-account-multiple-outline</v-icon> 参加人数
                </p>
              </v-col>
              <v-col cols=12 md="1" class="mt-n6">
                <p style="color:#ced4da; font-size:0.8rem;">15人</p>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols=12 md="2" align="center" class="mt-n6 ml-5">
                <p style="color:#ced4da; font-size:0.8rem;">
                  <v-icon color="#ced4da" small>mdi-tab</v-icon> カテゴリー
                </p>
              </v-col>
              <v-col cols=12 md="1" class="mt-n6 ml-n2">
                <p style="color:#ced4da; font-size:0.8rem;">{{ post.attributes.category.name }}</p>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols=12 md="2" align="center" class="ml-5 mt-n6">
                <p style="color:#ced4da; font-size:0.8rem;">
                  <v-icon color="#ced4da" small>mdi-laptop</v-icon> 使用ツール
                </p>
              </v-col>
              <v-col cols=12 md="1" class="mt-n6 ml-n2" v-for="(tool, index) in post.attributes.tools" :key="index">
                <p style="color:#ced4da; font-size:0.8rem;">{{ tool }}</p>
              </v-col>
            </v-row>
            <!-- <v-row>
              <v-col cols=12 md="3" class="ml-7 mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">
                  <v-icon small>mdi-comment-outline</v-icon> 主催者からのコメント
                </p>
              </v-col>
              <v-col cols=12 md="6" class="mt-n6">
                <p style="color:#efeff1; font-size:0.8rem;">悪口禁止
                </p>
              </v-col>
            </v-row> -->
            <v-row class="tag mt-n4 ml-n12">
              <v-col cols=12 md=1></v-col>
              <div v-for="(tag,index) in post.attributes.tag_list" :key="index">
                <v-col cols=12 md=1 class="ml-n1">
                  <router-link :to="{name: 'Tag', params: {name: tag }}">
                    <v-btn depressed class="rounded-s" x-small color="#46494c">
                      #{{ tag }}
                    </v-btn>
                  </router-link>
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
    simpleAxios,
    secureAxios
  } from '../backend/axios.js'
  import Avatar from '../components/perpage/TheAvatar.vue';
  import InfiniteLoading from 'vue-infinite-loading';
  import moment from 'moment';
  const ENTRY_URL = '/api/v1/entries'
  const CONTENT_URL = '/api/v1/categories'

  export default {
    name: 'Category-Posts',
    components: {
      'avatar': Avatar,
      'infinite-loading': InfiniteLoading,
    },
    data() {
      return {
        page: 1,
        pageSize: 9,
        posts: [],
        dialog: false,
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
        secureAxios.get(CONTENT_URL + `/` + `${this.$route.params.slug}`, {
            params: {
              page: this.page,
              per_page: this.pageSize,
              user_id: `${this.$store.state.currentUser.data.attributes.id}`,
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
      entryRequest(post) {
        secureAxios.post(ENTRY_URL, {
          post: post.id,
          user: post.user_id
        })
        post.attributes.can_request_entry = false
      },
      startTime(post) {
        return moment(post.attributes.start_date).format("YYYY/MM/DD hh:mm")
      },
      endTime(post) {
        return moment(post.attributes.end_date).format("YYYY/MM/DD hh:mm")
      }
    },
  }
</script>

<style scoped>
  .tile {
    margin: 10px;
    border-radius: 7px;
  }

  .tile:hover {
    background: #6c757d;
  }
</style>