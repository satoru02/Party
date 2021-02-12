<template>
  <v-app-bar fixed app style="background-color:#0e0e10">
    <v-row no-gutters dense>
      <v-col lg=4 xl=4 class="hidden-xs-only hidden-sm-only hidden-md-only mt-6">
        <router-link to="/">
          <v-toolbar-title>TITLE</v-toolbar-title>
        </router-link>
      </v-col>
      <v-col sm=2 md=4 lg=4 xl=4 class="mt-6 hidden-xs-only">
        <v-text-field rounded height="38" prepend-inner-icon="mdi-magnify" background-color="#212529" v-model="query"
          @keydown.enter="searchPost(query)" placeholder="検索"></v-text-field>
      </v-col>
      <v-col xs=12 sm=10 md=8 lg=4 xl=4>
        <v-row>
          <v-col lg=5 xl=1 class="hidden-xs-only" />
          <v-col lg=3 class=mt-1>
            <notification-menu />
          </v-col>
          <v-col lg=1 class="mt-2 ml-n4">
            <user-menu />
          </v-col>
          <v-col lg=1 class="mt-2 ml-5">
            <base-post-button />
          </v-col>
        </v-row>
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
      }
    }
  }
</script>

<style>
  .v-application--is-ltr .v-text-field .v-input__prepend-inner {
    margin-right: auto;
    padding-right: 17px;
    color:darkgrey;
    padding-top: 2px;
  }
</style>