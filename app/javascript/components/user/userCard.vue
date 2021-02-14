<template>
  <v-responsive class="overflow-y-auto flex-grow-1 flex-shrink-0" style="width:auto;" height=600>

    <div v-for="(post, index) in posts" :key="index">
      <v-sheet class="rounded-lg" color="#11151c" width="740"
        style="border: 1px solid hsla(0,0%,100%,.1); height:auto; width: auto; height:auto;">
        <v-row>
          <v-col cols=3 sm=2 md=2 lg=2 xl=2 class="mt-1 ml-2" align="center" color="#efeff1">
            <v-btn small color="#2d00f7">イベント</v-btn>
          </v-col>
          <v-col cols=5 sm=7 md=7 lg=8 xl=9 class="mt-2" align="start" color="#ffffff">
            <h2>{{ post.attributes.title }}</h2>
          </v-col>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="mt-2 ml-13"
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
          </v-col>
        </v-row>
        <v-divider />
        <v-row v-if="post.type === 'joined_post'">
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-n9">
            <router-link :to="{name: 'MyEvents', params: {id: `${post.attributes.host_user.id}`}}">
              <base-avatar :size="30" />
            </router-link>
          </v-col>
          <v-col cols=1 sm=1 md=1 class="hidden-lg-only hidden-xl-only" />
          <v-col cols=8 sm=8 md=8 lg=8 xl=8 class="mt-4 ml-n6">
            <h3 style="color:#adb5bd; font-size:0.5rem;">{{ post.attributes.host_user.username}}
              ({{ formalizeTime(post.attributes.created_at) }})</h3>
          </v-col>
        </v-row>

        <v-row no-gutters>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=11 sm=11 md=11 lg=11 xl=10 class="mt-3 ml-n8">
            <p style="color:#ced4da; font-size:0.8rem;">{{ post.attributes.content }}</p>
          </v-col>
        </v-row>

        <v-row no-gutters>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=3 sm=2 md=3 lg=3 xl=2 align="start" class="ml-n8">
            <p style="color:#ced4da; font-size:0.8rem;">
              <v-icon color="#ced4da" small>mdi-calendar-clock</v-icon> 開催日程
            </p>
          </v-col>
          <v-col cols=2 sm=2 md=1 class="hidden-lg-only" />
          <v-col cols=7 sm=7 md=8 lg=5 xl=5 align="start" class="ml-n16">
            <p style="color:#ced4da; font-size:0.8rem;">{{ formalizeTime(post.attributes.start_date) }} 〜
              {{ formalizeTime(post.attributes.end_date) }}</p>
          </v-col>
        </v-row>

        <v-row no-gutters>
          <v-col cols=1 sm=1 md=1 lg=1 />
          <v-col cols=3 sm=2 md=3 lg=3 xl=2 align="start" class="ml-n8">
            <p style="color:#ced4da; font-size:0.8rem;">
              <v-icon color="#ced4da" small>mdi-account-multiple-outline</v-icon> 参加人数
            </p>
          </v-col>
          <v-col cols=2 sm=2 md=1 class="hidden-lg-only" />
          <v-col cols=5 sm=5 md=8 lg=5 xl=5 align="start" class="ml-n16">
            <p style="color:#ced4da; font-size:0.8rem;">15人</p>
          </v-col>
        </v-row>

        <v-row no-gutters>
          <v-col cols=1 sm=1 md=1 lg=1 />
          <v-col cols=3 sm=2 md=3 lg=3 xl=2 align="start" class="ml-n8">
            <p style="color:#ced4da; font-size:0.8rem;">
              <v-icon color="#ced4da" small>mdi-tab</v-icon> カテゴリー
            </p>
          </v-col>
          <v-col cols=2 sm=2 md=1 class="hidden-lg-only" />
          <v-col cols=5 sm=5 md=8 lg=5 xl=5 align="start" class="ml-n16">
            <p style="color:#ced4da; font-size:0.8rem;">{{ post.attributes.category.name }}</p>
          </v-col>
        </v-row>

        <v-row no-gutters>
          <v-col cols=1 sm=1 md=1 lg=1 />
          <v-col cols=3 sm=2 md=3 lg=3 xl=2 align="start" class="ml-n8">
            <p style="color:#ced4da; font-size:0.8rem;">
              <v-icon color="#ced4da" small>mdi-laptop</v-icon> 使用ツール
            </p>
          </v-col>
          <v-col cols=1 sm=2 md=1 class="hidden-lg-only" />
          <v-col class="ml-n16" align="start" cols=1 sm=1 md=1 lg=1 xl=1 v-for="(tool, index) in post.attributes.tools"
            :key="index">
            <p style="color:#ced4da; font-size:0.8rem;">{{ tool }}</p>
          </v-col>
        </v-row>

        <v-row class="tag mt-n4 ml-n12">
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <div v-for="(tag,index) in post.attributes.tag_list" :key="index">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-n1">
              <router-link :to="{name: 'Tag', params: {name: tag }}">
                <v-btn depressed class="rounded-s" x-small color="#46494c">
                  #{{ tag }}
                </v-btn>
              </router-link>
            </v-col>
          </div>
          <v-col cols=8 sm=8 md=8 lg=8 xl=8 />
        </v-row>
      </v-sheet>

      <p></p>

      <v-dialog light v-model="delete_check_dialog" width="300">
        <v-card>
          <v-card-title>この投稿を削除しますか？</v-card-title>
          <v-card-actions>
            <v-spacer />
            <v-btn color="green darken-1" text @click="deletePost(delete_post), delete_check_dialog = false">
              削除する
            </v-btn>
            <v-btn color="green darken-1" text @click="delete_check_dialog = false">
              キャンセル
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>

  </v-responsive>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import moment from 'moment';
  import BaseAvatar from '../base/BaseAvatar';
  const CONTENT_URL = '/api/v1/posts'

  export default {
    name: "UserCard",
    props: {
      posts: Array
    },
    components: {
      'base-avatar': BaseAvatar
    },
    data() {
      return {
        dialog: false,
        delete_check_dialog: false,
        delete_post: ''
      }
    },
    methods: {
      formalizeTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      },
      deletePost(post) {
        secureAxios.delete(CONTENT_URL + `/` + `${post}`)
          .then(response => this.deleteSuccessful(response))
          .catch(error => this.deleteFailed(error))
      },
      deleteSuccessful(response) {
        this.$router.go(this.$router.currentRoute)
      }
    }
  }
</script>

<style scoped>
  h2 {
    font-size: 0.9rem;
  }
</style>