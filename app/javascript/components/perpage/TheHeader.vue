<template>
  <v-app-bar fixed app style="background-color:#161a1d">
    <router-link to="/">
    <v-toolbar-title>TITLE</v-toolbar-title>
    </router-link>
    <v-row>
      <v-col cols=12 md=3></v-col>
      <v-col cols=12 md=5 class="mt-7 ml-8" >
        <v-text-field rounded color="#00b4d8" background-color="#0d1117" v-model="query" @keydown.enter="searchPost(query)" placeholder="検索" outlined dense></v-text-field>
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
      showAdminLink() {
        return this.$store.getters.isAdmin || this.$store.getters.isManager
      }
    }
  }
</script>

