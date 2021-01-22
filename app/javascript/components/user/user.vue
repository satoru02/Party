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
        <v-col cols=12 md=auto class="ml-n6">
          <v-btn v-for="(n, index) in items" :key="index" color="#efeff1" text rounded class="my-2 mt-8">
            {{ n }}
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
                <v-list-title class="pl-1">
                  <v-icon small>mdi-twitter</v-icon>
                </v-list-title>
              </v-col>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">Location:</h3>
              <h3 class="ml-5" style="color:#efeff1; font-size:0.7rem">{{ user.location }}</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">Joined:</h3>
              <h3 class="ml-9" style="color:#efeff1; font-size:0.7rem">2021/02/21</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">About:</h3>
              <h3 class="ml-9" style="color:#efeff1; font-size:0.7rem">{{ user.about }}</h3>
            </v-list-item>
          </v-sheet>
        </v-col>
        <v-col cols=12 md=8 class="mt-n16 ml-12">
          <event-card :posts="$store.state.currentUser.data.relationships.posts.data"></event-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
  import Log from './log.vue'
  import Avatar from '../perpage/TheAvatar'
  import EventCard from '../user/EventCard';

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
      'event-card': EventCard,
    },
    data() {
      return {
        user: '',
        error: '',
        items: {
          Events: "My Events 6",
          JoinedEvents: "Joined Events 100",
          Activity: "Activity",
          Monthly: "Recommend",
          Followers: "Followers",
          Following: "Following",
          Settings: "Settings"
        }
      }
    },
    created() {
      this.fecthUserInformation()
    },
    methods: {
      fecthUserInformation() {
        simpleAxios.get(USER_INFO_URL + `${this.$route.params.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.user = response.data.data.attributes
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      }
    }
  }
</script>