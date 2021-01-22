<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols=12></v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=2>
          <avatar :size="140" :avatar_url="user.avatar_url"></avatar>
        </v-col>
        <v-col cols=12 md=auto class="ml-9">
          <v-btn v-for="(n, index) in items" :key="index" color="#efeff1" text rounded class="my-2 mt-8">
            {{ n }}
          </v-btn>
          <v-divider dark></v-divider>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=3 class="ml-10 mt-4">
        </v-col>
        <v-col cols=12 md=auto class="mt-n16">
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
          About: "About"
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