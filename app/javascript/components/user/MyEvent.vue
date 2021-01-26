<template>
  <v-responsive class="overflow-y-auto flex-grow-1 flex-shrink-0" style="max-width: 100%;" height="600">
    <div v-for="(post, index) in posts" :key="index">
      <v-sheet color="#11151c" class="rounded-lg" width="740"
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
          <v-col cols=12 md=1 class="mt-2 ml-16">
            <v-menu left offset-y nudge-width="140" nudge-height="100">
              <template v-slot:activator="{ on, attrs}">
                <v-icon color="#edf6f9" v-bind="attrs" v-on="on">mdi-dots-horizontal</v-icon>
              </template>
              <v-list class="rounded-s" style="background-color:#343a40;">
                <router-link :to="{ name: 'PostEdit', params: {id: `${post.attributes.id }`}}">
                  <v-list-item v-if="$store.state.currentUser.data.attributes.id === post.attributes.user_id">
                    <v-list-item-title class="ml-5">編集する</v-list-item-title>
                  </v-list-item>
                </router-link>
                <v-list-item>
                  <!-- <router-link :to="{ name: 'PostEdit', params: {id: `${post.attributes.id }`}}"> -->
                  <v-list-item-title class="ml-5">削除する</v-list-item-title>
                  <!-- </router-link> -->
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
          <div v-for="(n,index) in post.attributes.tags" :key="index">
            <v-col cols=12 md=1 class="ml-n4">
              <v-btn depressed class="rounded-s" x-small color="#46494c">
                {{ n.name }}
              </v-btn>
            </v-col>
          </div>
        </v-row>
      </v-sheet>
      <p></p>
    </div>
  </v-responsive>
</template>

<script>
  import moment from 'moment';
  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios.js'
  const USERS_POST_INFO_URL = '/api/v1/posts/'

  export default {
    name: "MyEvent",
    data() {
      return {
        posts: []
      }
    },
    created() {
      this.fetchUsersPost()
    },
    methods: {
      fetchUsersPost() {
        simpleAxios.get(USERS_POST_INFO_URL, {
            params: {
              user_id: `${this.$route.params.id}`,
              position: 'my_events'
            }
          })
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.posts = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      },
      postTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      }
    }
  }
</script>