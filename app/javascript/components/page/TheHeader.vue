<template>
  <v-app-bar fixed app style="background-color:#0e0e10">
    <v-row dense>
      <v-col md=1 lg=1 xl=1 class="hidden-xs-only hidden-sm-only" />
      <v-col lg=1 xl=1 class="hidden-xs-only hidden-sm-only hidden-md-only mt-7" align="start">
        <v-toolbar-title class="top ml-n7" @click="moveTop()">Bundly</v-toolbar-title>
      </v-col>
      <v-col md=1 lg=1 xl=1 class="hidden-xs-only hidden-sm-only ml-n4" />
      <v-col md=2 lg=3 xl=3 class="mt-6 hidden-xs-only hidden-sm-only">
        <v-text-field rounded height="38" prepend-inner-icon="mdi-magnify" background-color="#212529" v-model="query"
          @keydown.enter="searchPost(query)" placeholder="Search" />
      </v-col>
      <v-col md=2 lg=3 xl=3 class="ml-5 hidden-xs-only hidden-sm-only" />
      <v-col cols=4 sm=4 md=2 lg=1 xl=1 class="mt-1 ml-4">
        <notification-menu />
      </v-col>
      <v-col cols=4 sm=4 md=2 lg=1 xl=1 class="mt-1">
        <user-menu />
      </v-col>
      <v-col cols=4 sm=4 md=2 lg=1 xl=1 class="mt-6 ml-n16" align="start">
        <base-post-button />
      </v-col>
    </v-row>
  </v-app-bar>
</template>

<script>
  import NotificationMenu from './TheNotificationMenu';
  import BasePostButton from '../base/BasePostButton';
  import UserMenu from '../page/TheUserMenu';

  export default {
    name: 'TheHeader',
    components: {
      'notification-menu': NotificationMenu,
      'base-post-button': BasePostButton,
      'user-menu': UserMenu,
    },
    data() {
      return {
        query: ''
      }
    },
    methods: {
      searchPost(query) {
        this.$router.push({
          name: "Search",
          params: {
            query: query
          }
        }).catch(err => {})
      },
      showAdminLink() {
        return this.$store.getters.isAdmin || this.$store.getters.isManager
      },
      moveTop() {
        this.$router.push({
          name: 'Top'
        })
      }
    }
  }
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

  .top {
    cursor: pointer;
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    color: #ffffff;
  }
</style>