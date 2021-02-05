<template>
  <v-app-bar fixed app style="background-color:#161a1d">
    <router-link to="/">
    <v-toolbar-title>TITLE</v-toolbar-title>
    </router-link>
    <v-row>
      <v-col cols=12 md=3></v-col>
      <v-col cols=12 md=5 class="mt-6 ml-8" >
        <v-text-field rounded height="39" prepend-inner-icon="mdi-magnify" background-color="#212529" v-model="query" @keydown.enter="searchPost(query)" placeholder="検索"></v-text-field>
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

<style>
.v-application--is-ltr .v-text-field .v-input__prepend-inner {
  margin-right: auto;
  padding-right: 15px;
  margin-left: -10px;
}

.v-application--is-ltr .v-text-field .v-input__prepend-inner .v-input__icon {
  height: 30px;
  color: #343a40;
}
</style>