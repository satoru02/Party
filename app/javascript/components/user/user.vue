<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols=12></v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=3 class="ml-16">
          <avatar :size="140" :avatar_url="$store.state.currentUser.data.attributes.avatar_url"></avatar>
        </v-col>
        <v-col cols=12 md=auto class="ml-n3">
          <v-btn v-for="(n, index) in items" :key="index" color="#efeff1" text rounded class="my-2 mt-8">
            <router-link :to="{ name: n.name }">
              <div style="color:#efeff1; font-size:0.7rem;">{{ n.title }}</div>
            </router-link>
          </v-btn>
          <v-divider dark class="mt-n1"></v-divider>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=3 class="ml-n2 mt-2">
          <v-sheet color="#121212" class="rounded-lg" height="200"
            style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 270px; max-width: 100%; max-height:1000px;">
            <h1 class="ml-3 mb-2 mt-2">@{{ $store.state.currentUser.data.attributes.name }}</h1>
            <v-divider></v-divider>
            <v-list-item>
              <h3 style="color:#efeff1">主催回数：</h3>
              <h3 class="ml-5" style="color:#efeff1; font-size:0.9rem">
                {{ $store.state.currentUser.data.relationships.posts.data.length }}</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">参加回数：</h3>
              <!-- <h3 class="ml-9" style="color:#efeff1; font-size:0.9rem">{{ users_joined_events.length }}</h3> -->
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">場所：</h3>
              <h3 class="ml-5" style="color:#efeff1; font-size:0.7rem">{{ $store.state.currentUser.data.attributes.location }}</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">登録日：</h3>
              <h3 class="ml-9" style="color:#efeff1; font-size:0.8rem">{{ joinedTime($store.state.currentUser.data.attributes.activated_at) }}</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">自己紹介：</h3>
              <h3 class="ml-9" style="color:#efeff1; font-size:0.7rem">{{ $store.state.currentUser.data.attributes.about }}</h3>
            </v-list-item>
            <v-list-item class="mt-n7">
              <h3 style="color:#efeff1">フォロー：</h3>
              <v-col cols=5 md=1>
                <v-list-item class="pl-1">
                  <v-icon v-if="$store.state.currentUser.data.attributes.facebook_url" small>mdi-facebook</v-icon>
                </v-list-item>
              </v-col>
              <v-col cols=5 md=1>
                <v-list-item class="pl-1">
                  <v-icon v-if="$store.state.currentUser.data.attributes.youtube_url" small>mdi-youtube</v-icon>
                </v-list-item>
              </v-col>
              <v-col cols=5 md=1>
                <v-list-item class="pl-1">
                  <v-icon v-if="$store.state.currentUser.data.attributes.instagram_url" small>mdi-instagram</v-icon>
                </v-list-item>
              </v-col>
            </v-list-item>
          </v-sheet>
        </v-col>
        <v-col cols=12 md=8 class="mt-n16 ml-12">
          <router-view></router-view>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
  import Log from './log.vue'
  import Avatar from '../perpage/TheAvatar'
  import moment from 'moment';

  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios.js'

  const USER_INFO_URL = '/api/v1/users/'

  export default {
    name: 'User',
    components: {
      'log': Log,
      'avatar': Avatar,
    },
    data() {
      return {
        user: '',
        users_post: [],
        users_joined_events: [],
        error: '',
        items: {
          Events: {
            title: "主催イベント",
            name: 'MyEvents',
            link: ''
          },
          JoinedEvents: {
            title: "参加イベント",
            name: 'JoinedEvents',
            link: ''
          },
          Activity: {
            title: "アクティビティ",
            name: '',
            link: ''
          },
          Monthly: {
            title: "レコメンド",
            name: '',
            link: '',
          },
          Followers: {
            title: "フォロワー",
            name: '',
            link: ''
          },
          Following: {
            title: "フォロー",
            name: '',
            link: ''
          },
          About: {
            title: "プロフィール",
            name: 'About',
            link: ''
          }
        }
      }
    },
    methods: {
      joinedTime(time) {
        return moment(time).format("YYYY/MM/DD")
      },
    }
  }
</script>

<style>
</style>