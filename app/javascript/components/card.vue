<template>
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
            </v-row>
            <v-divider></v-divider>
            <v-row>
              <v-col cols=12 md=11 class="ml-7 mt-3">
                <p style="color:#ced4da; font-size:0.8rem;">{{ post.attributes.content }}</p>
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
    </v-container>
</template>

<script>
  import { secureAxios } from '../backend/axios';
  import moment from 'moment';
  const ENTRY_URL = '/api/v1/entries'

  export default {
    name: "card",
    props: {
      posts: Array
    },
    data(){
      return {
        dialog: false
      }
    },
    methods: {
      startTime(post) {
        return moment(post.attributes.start_date).format("YYYY/MM/DD hh:mm")
      },
      endTime(post) {
        return moment(post.attributes.end_date).format("YYYY/MM/DD hh:mm")
      },
      entryRequest(post) {
        secureAxios.post(ENTRY_URL, {
          post: post.attributes.id,
          user: post.attributes.user_id
        })
        post.attributes.can_request_entry = false
      }
    }
  }
</script>