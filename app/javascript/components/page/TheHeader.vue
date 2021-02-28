<template>
  <v-app-bar fixed app style="background-color:#0e0e10">
    <v-row dense>
      <v-col md=1 lg=1 xl=1 class="hidden-xs-only hidden-sm-only" />
      <v-col cols=2 lg=1 xl=1 class="hidden-sm-only hidden-md-only mt-7" align="start">
        <v-toolbar-title :class="[$vuetify.breakpoint.mdAndUp ? 'top ml-n7 mt-n1': 'top mt-n1']" @click="moveTop()">PartyKit</v-toolbar-title>
      </v-col>
      <v-col cols=1 md=1 lg=1 xl=1 class="hidden-sm-only ml-n4" />
      <v-col cols=8 md=2 lg=3 xl=3 class="mt-6 hidden-sm-only">
        <v-text-field rounded height="33" prepend-inner-icon="mdi-magnify" background-color="#212529" v-model="query"
          @keydown.enter="searchPost(query)" placeholder="検索" />
      </v-col>
      <v-col md=2 lg=3 xl=3 class="ml-5 hidden-xs-only hidden-sm-only" />
      <v-col sm=4 md=2 lg=1 xl=1 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1 ml-4': 'hidden-xs-only']">
        <notification-menu />
      </v-col>
      <v-col cols=1 sm=4 md=2 lg=1 xl=1 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1': 'mt-1 ml-4']">
        <user-menu />
      </v-col>
      <v-col sm=4 md=2 lg=1 xl=1 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-6 ml-n16': 'hidden-xs-only']" align="start">
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