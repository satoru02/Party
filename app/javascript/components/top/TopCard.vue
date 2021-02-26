<template>
  <v-container>
    <v-row no-gutters>
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 v-for="post in posts" :key="post.attributes.id + Math.random()" :title="post.attributes.title"
        :user_id="post.attributes.user_id" class="mb-6 mt-n2">
        <v-sheet class="rounded-lg" color="#11151c"
          style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 150px; width:auto;">
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 class="mt-1 mb-1" color="#efeff1">
              <v-btn min-width="100" small color="#2d00f7">{{ post.attributes.category.name }}</v-btn>
            </v-col>
            <v-col cols=1 sm=1 class="hidden-lg-only hidden-xl-only" />
            <v-col cols=6 sm=6 md=6 lg=8 xl=8 class="mt-1" color="#ffffff">
              <h3>{{ post.attributes.title }}</h3>
            </v-col>
            <!-- <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="mt-2">
              <v-menu left offset-y nudge-width="140" nudge-height="100" nudge-bottom="10">
                <template v-slot:activator="{ on, attrs }">
                  <v-icon color="#edf6f9" v-bind="attrs" v-on="on">mdi-dots-horizontal</v-icon>
                </template>
                <v-list class="rounded-s" style="background-color:#343a40;">
                  <v-list-item class="tile">
                    <v-list-item-title class="ml-5">通報する</v-list-item-title>
                  </v-list-item>
                  <v-list-item class="tile">
                    <v-list-item-title style="font-weight: bold" class="ml-5">ツイートする</v-list-item-title>
                  </v-list-item>
                </v-list>
              </v-menu>
            </v-col> -->
          </v-row>
          <v-divider dark />
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=2 sm=2 md=2 lg=1 xl=1>
              <router-link :to="{name: 'MyEvents', params: {id: `${post.attributes.user.id}`}}">
                <base-avatar />
              </router-link>
            </v-col>
            <v-col cols=8 sm=8 md=8 lg=8 xl=8 class="mt-4 ml-n4">
              <h3 style="color:#adb5bd; font-size:0.5rem;">{{ post.attributes.user.username}}
                ({{ formalizeTime(post.attributes.created_at) }})</h3>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1　/>
            <v-col cols=10 sm=10 md=10 lg=10 xl=10 class="mt-n3">
              <p style="color:#ced4da; font-size:1rem;">{{ post.attributes.content }}</p>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-row>
            <v-col />
          </v-row>
          <v-row class="mt-n3">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=4 sm=4 md=3 lg=2 xl=2 class="mt-n6">
              <p style="color:#ced4da; font-size:0.8rem;">
                <v-icon color="#ced4da" small>mdi-calendar-clock</v-icon> 開催日程
              </p>
            </v-col>
            <v-col cols=7 sm=7 md=7 lg=5 xl=5 align="start" class="mt-n6">
              <p style="color:#ced4da; font-size:0.8rem;">{{ formalizeTime(post.attributes.start_date) }} 〜
                {{ formalizeTime(post.attributes.end_date) }}</p>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=4 sm=4 md=3 lg=2 xl=2 class="mt-n6">
              <p style="color:#ced4da; font-size:0.8rem;">
                <v-icon color="#ced4da" small>mdi-account-multiple-outline</v-icon> 参加人数
              </p>
            </v-col>
            <v-col cols=6 sm=6 md=2 lg=1 xl=1 class="mt-n6">
              <p style="color:#ced4da; font-size:0.8rem;">15人</p>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=4 sm=4 md=3 lg=2 xl=2 class="mt-n6">
              <p style="color:#ced4da; font-size:0.8rem;">
                <v-icon color="#ced4da" small>mdi-tab</v-icon> カテゴリー
              </p>
            </v-col>
            <v-col cols=6 sm=6 md=1 lg=1 xl=1 class="mt-n6">
              <p style="color:#ced4da; font-size:0.8rem;">{{ post.attributes.category.name }}</p>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=4 sm=4 md=3 lg=2 xl=2 class="mt-n6">
              <p style="color:#ced4da; font-size:0.8rem;">
                <v-icon color="#ced4da" small>mdi-laptop</v-icon> 使用ツール
              </p>
            </v-col>
            <v-col cols=2 sm=2 md=1 lg=1 xl=1 class="mt-n6" v-for="(tool, index) in post.attributes.tools"
              :key="index">
              <p style="color:#ced4da; font-size:0.8rem;">{{ tool }}</p>
            </v-col>
          </v-row>
          <v-row class="mt-n4">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <div v-for="(tag,index) in post.attributes.tag_list" :key="index">
              <v-col cols=1 sm=1 md=1 lg=1 xl=1>
                <router-link :to="{name: 'Tag', params: {name: tag }}">
                  <v-btn depressed class="rounded-s" x-small color="#46494c">
                    #{{ tag }}
                  </v-btn>
                </router-link>
              </v-col>
            </div>
            <v-col cols=8 sm=8 md=8 lg=8 xl=8 />
          </v-row>
          <v-row>
            <v-col cols=7 sm=7 md=8 lg=8 xl=8 />
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 class="mb-2"
              v-if="($store.state.currentUser.data.attributes.id !== post.attributes.user_id) && (post.attributes.can_request_entry === true)">
              <v-btn class="rounded-lg" style="background-color:#29bf12;" @click="entryRequest(post), dialog = true"
                elevation="6">
                <v-icon>mdi-hail</v-icon>
                <h3>エントリーする</h3>
              </v-btn>
            </v-col>
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 class="mb-1"
              v-if="($store.state.currentUser.data.attributes.id !== post.attributes.user_id) && (post.attributes.can_request_entry === false)">
              <v-btn class="rounded-lg" style="background-color:#212529;">
                <v-icon color="#6c757d">mdi-hail</v-icon>
                <h3 style="color:#6c757d">エントリー済み</h3>
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
            <v-spacer />
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
  import {
    secureAxios
  } from '../../backend/axios';
  import moment from 'moment';
  import BaseAvatar from '../../components/base/BaseAvatar';
  const ENTRY_URL = '/api/v1/entries'

  export default {
    name: "TopCard",
    props: {
      posts: {
        type: Array,
        required: true
      }
    },
    components: {
      'base-avatar': BaseAvatar
    },
    data() {
      return {
        dialog: false
      }
    },
    methods: {
      formalizeTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
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