<template>
  <v-app-bar app style="background-color:#161a1d">
    <v-container>
      <v-row class="d-flex justify-space-around">
        <v-col>
          <router-link to="/">
            <h1 class="pa-3 mt-5 ml-n16" style="color:white">KIT PAC</h1>
          </router-link>
        </v-col>
        <v-spacer></v-spacer>
        <v-col cols="6">
          <v-text-field append-icon v-model="query" @keydown.enter="searchPost(query)" dark class="mt-7 ml-9 mr-n14" placeholder="Search" filled rounded dense></v-text-field>
        </v-col>
        <v-spacer></v-spacer>
        <v-col class="pa-1 mt-8 mr-n9">
          <!-- <notifications></notifications> -->
        </v-col>
        <v-col class="pa-2 mt-11 mr-n16">
          <v-icon size=23>mdi-chat-outline</v-icon>
        </v-col>
        <v-col>
          <userMenu></userMenu>
        </v-col>
        <v-col class="mt-8 mr-n16 ml-n16">
          <postButton></postButton>
        </v-col>
      </v-row>
    </v-container>
  </v-app-bar>
</template>

<script>
  import Notifications from './TheNotifications';
  import PostButton from '../postButton';
  import UserMenu from '../perpage/TheUserMenu';

  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios.js';

  const LOGOUT_URL = '/api/v1/login';

  export default {
    name: 'top-header',
    components: {
      'notifications': Notifications,
      'postButton': PostButton,
      'userMenu': UserMenu,
    },
    data() {
      return {
        query: ''
      }
    },
    methods: {
      searchPost(query){
        this.$router.push({name: "Search", params: { query: query } }).catch(err => {})
      },
      setError(error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      signOut() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.delete(LOGOUT_URL + `/` + `${this.$store.state.currentUser.data.attributes.id}`)
          .then(response => {
            this.$store.commit('unsetCurrentUser')
            this.$router.replace('/')
          })
          .catch(error => this.setError(error, 'Cannot sign out'))
      },
      showAdminLink() {
        return this.$store.getters.isAdmin || this.$store.getters.isManager
      }
    }
  }
</script>

