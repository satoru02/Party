<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols=12></v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=3 class="ml-16">
          <avatar :size="140" :avatar_url="user.avatar_url"></avatar>
        </v-col>
        <v-col cols=12 md=auto class="ml-n2">
          <v-btn v-for="(n, index) in items" :key="index" color="#efeff1" text rounded class="my-2 mt-8">
            <router-link :to="{ name: n.name }">
              <div style="color:#efeff1">{{ n.title }}</div>
            </router-link>
          </v-btn>
          <v-divider dark class="mt-n1"></v-divider>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=3 class="ml-n2 mt-2">
          <v-sheet color="#121212" class="rounded-lg" height="200"
            style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 270px; max-width: 100%; max-height:1000px;">
            <h1 class="ml-3 mb-2 mt-2">@{{ user.name }}</h1>
            <v-divider></v-divider>
            <v-list-item>
              <h3 style="color:#efeff1">Follow on:</h3>
              <v-col cols=5 md=1 v-for="(n, index) in 2" :key="index">
                <v-list-item class="pl-1">
                  <v-icon small>mdi-twitter</v-icon>
                </v-list-item>
              </v-col>
            </v-list-item>
            <v-list-item class="mt-n7">
              <h3 style="color:#efeff1">Location:</h3>
              <h3 class="ml-5" style="color:#efeff1; font-size:0.7rem">{{ user.location }}</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">Joined:</h3>
              <h3 class="ml-9" style="color:#efeff1; font-size:0.8rem">{{ joinedTime(user.activated_at) }}</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">About:</h3>
              <h3 class="ml-9" style="color:#efeff1; font-size:0.7rem">{{ user.about }}</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">Organize:</h3>
              <h3 class="ml-5" style="color:#efeff1; font-size:0.9rem">{{ users_post.length }}</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">Joined:</h3>
              <h3 class="ml-10" style="color:#efeff1; font-size:0.9rem">{{ users_joined_events.length }}</h3>
            </v-list-item>
          </v-sheet>
        </v-col>
        <v-col cols=12 md=8 class="mt-n16 ml-12">
          <router-view :posts="users_post" :rooms="users_joined_events"></router-view>
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
            title: "My Events",
            name: 'MyEvents',
            link: ''
          },
          JoinedEvents: {
            title: "Joined Events",
            name: 'JoinedEvents',
            link: ''
          },
          Activity: {
            title: "Activity",
            name: '',
            link: ''
          },
          Monthly: {
            title: "Recommend",
            name: '',
            link: '',
          },
          Followers: {
            title: "Followers",
            name: '',
            link: ''
          },
          Following: {
            title: "Following",
            name: '',
            link: ''
          },
          Settings: {
            title: "Settings",
            name: '',
            link: ''
          }
        }
      }
    },
    created() {
      this.fecthUserInformation()
    },
    methods: {
      joinedTime(time) {
        return moment(time).format("YYYY/MM/DD")
      },
      fecthUserInformation() {
        simpleAxios.get(USER_INFO_URL + `${this.$route.params.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.user = response.data.data.attributes
        this.users_post = response.data.included.reverse()
        this.users_joined_events = response.data.data.attributes.joined_event.reverse()
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      }
    }
  }
</script>

<style>
</style>