<template>
  <v-app-bar absolute app style="background-color:#161a1d">
    <router-link to="/">
    <v-toolbar-title>TITLE</v-toolbar-title>
    </router-link>
    <v-row>
      <v-col cols=12 md=3></v-col>
      <v-col cols=12 md=5 class="mt-7">
        <v-text-field append-icon v-model="query" @keydown.enter="searchPost(query)" dark placeholder="検索する" filled rounded dense></v-text-field>
      </v-col>
      <v-col cols=12 md=1></v-col>
      <v-col cols=12 md=1 class="mt-6">
        <notifications></notifications>
      </v-col>
      <v-col cols=12 md=1 class="ml-n5 mt-6">
        <userMenu></userMenu>
      </v-col>
      <v-col cols=12 md=1 class="ml-n6 mt-7">
        <postButton></postButton>
      </v-col>
    </v-row>
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

