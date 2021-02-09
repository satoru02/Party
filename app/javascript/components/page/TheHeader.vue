<template>
  <v-app-bar
    fixed
    app
    style="background-color:#161a1d">
    <router-link to="/">
      <v-toolbar-title>TITLE</v-toolbar-title>
    </router-link>
    <v-row>
      <v-col cols=12 md=3 />
      <v-col cols=12 md=5 class="mt-6 ml-8" >
        <v-text-field rounded height="39" prepend-inner-icon="mdi-magnify" background-color="#212529" v-model="query" @keydown.enter="searchPost(query)" placeholder="検索"></v-text-field>
      </v-col>
      <v-col cols=12 md=1 />
      <v-col cols=12 md=1 class="mt-6">
        <notification-menu />
      </v-col>
      <v-col cols=12 md=1 class="ml-n5 mt-6">
        <user-menu />
      </v-col>
      <v-col cols=12 md=1 class="ml-n6 mt-7">
        <base-button />
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
      'base-button': BasePostButton,
      'user-menu': UserMenu,
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

<style scoped>
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