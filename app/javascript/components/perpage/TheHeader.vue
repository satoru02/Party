<template>
  <v-app-bar app style="background-color:#0b090a">
    <v-container>
      <v-row class="d-flex justify-space-around">
        <v-col>
          <router-link to="/">
            <h1 class="pa-3 mt-5" style="color:white">VIDEOKIT</h1>
          </router-link>
        </v-col>
        <v-spacer></v-spacer>
        <v-col cols="7">
          <v-text-field class="mt-7 pr-4 pl-3" placeholder="Search" filled rounded dense></v-text-field>
        </v-col>
        <v-spacer></v-spacer>
        <v-col class="pa-2 mt-10 mr-3">
          <!-- <notifications></notifications> -->
          <v-icon size=28>mdi-bell</v-icon>
        </v-col>
        <v-col class="pa-2 mt-10 mr-1">
          <v-icon size=28>mdi-chat</v-icon>
        </v-col>
        <v-col>
          <router-link :to="{ name: 'User', params: {id: `${this.$store.state.currentUser.id}`} }">
            <avatar class="mt-8 mr-2"></avatar>
          </router-link>
        </v-col>
        <v-col class="mt-8">
          <postButton></postButton>
        </v-col>
      </v-row>
    </v-container>
  </v-app-bar>
</template>

<script>
  import Avatar from './TheAvatar.vue';
  import Notifications from './TheNotifications';
  import PostButton from '../postButton';
  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios.js';
  const LOGOUT_URL = '/api/v1/login';

  export default {
    name: 'top-header',
    components: {
      'avatar': Avatar,
      'notifications': Notifications,
      'postButton': PostButton
    },
    methods: {
      setError(error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      signOut() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.delete(LOGOUT_URL + `/` + `${this.$store.state.currentUser.id}`)
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