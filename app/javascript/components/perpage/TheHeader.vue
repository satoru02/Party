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
          <v-text-field dark class="mt-7 pl-n7" placeholder="Search" filled rounded dense></v-text-field>
        </v-col>
        <v-spacer></v-spacer>
        <v-col class="pa-2 mt-11 mr-n16">
          <!-- <notifications></notifications> -->
          <v-icon size=23>mdi-bell</v-icon>
        </v-col>
        <v-col class="pa-2 mt-11 mr-n16">
          <v-icon size=23>mdi-chat</v-icon>
        </v-col>
        <v-col>
          <!-- <router-link :to="{ name: 'User', params: {id: `${this.$store.state.currentUser.id}`} }"> -->
          <!-- <avatar class="mt-9 mr-n8"></avatar> -->
          <!-- <userMenu></userMenu> -->
          <!-- </router-link> -->
          <v-menu open-on-hover offset-y left nudge-height=800 nudge-width=150 >
            <template v-slot:activator="{ on, attrs }">
              <div v-bind="attrs" v-on="on">
                <avatar class="mt-9 mr-n8"></avatar>
              </div>
            </template>
            <v-list class="rounded-lg" style="background-color:#343a40;">
              <v-list-item class="tile" v-for="(item,index) in items" :key="index">
                <v-list-item-title style="color:#ced4da">{{ item.title }}</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        </v-col>
        <v-col class="mt-8 mr-n16 ml-n16">
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
  import UserMenu from '../perpage/TheUserMenu';

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
      'postButton': PostButton,
      'userMenu': UserMenu
    },
    data() {
      return {
        items: [{
            title: 'Profile'
          },
          {
            title: 'Rooms'
          },
          {
            title: 'Friends'
          },
          {
            title: 'Create Post'
          },
          {
            title: 'Edit Post'
          },
          {
            title: 'Settings'
          },
          {
            title: 'Help'
          },
          {
            title: 'Sign out'
          }
        ],
      }
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

<style scoped>
  .tile {
    margin: 10px;
    border-radius: 7px;
  }
  .tile:hover {
    background: #2d00f7;
  }
</style>