<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
      </v-row>
      <v-row>
        <v-col md=3 lg=3 xl=3 align="center" class="hidden-xs-only hidden-sm-only">
          <base-avatar class="ml-6" :size="150" :avatar_url="user.avatar_url" />
          <v-row>
            <v-col lg=12 xl=12 />
          </v-row>
          <v-sheet color="#11151c" class="rounded-lg" width="230"
            style="border: 1px solid hsla(0,0%,100%,.1); height:auto; max-width: 100%;">
            <v-row>
              <v-col lg=3 xl=3>
                <h3 class="ml-3 mb-2 mt-2" style="font-size:0.8rem;">{{ user.username }}</h3>
              </v-col>
              <v-col lg=3 xl=3 />
              <v-col lg=4 xl=4 class="ml-2 mt-1">
                <user-follow-button v-if="this.$store.state.currentUser.data.attributes.id != this.$route.params.id"
                  :user_id="user.id"
                  :followed="this.$store.state.currentUser.data.attributes.following.includes(user.id) ? true : false" />
              </v-col>
            </v-row>
            <v-divider />
            <v-list-item>
              <h3 style="color:#efeff1">主催回数：</h3>
              <h3 class="ml-4" style="color:#efeff1; font-size:0.8rem">
                {{ events.length }}回</h3>
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">参加回数：</h3>
              <!-- <h3 class="ml-9" style="color:#efeff1; font-size:0.9rem">{{ users_joined_events.length }}</h3> -->
            </v-list-item>
            <v-list-item class="mt-n4">
              <h3 style="color:#efeff1">場所：</h3>
              <h3 class="ml-11" style="color:#efeff1; font-size:0.8rem">{{ user.location }}</h3>
            </v-list-item>
            <v-list-item class="mt-n7">
              <h3 style="color:#efeff1">フォロー：</h3>
              <v-col md=1 lg=1 xl=1>
                <v-list-item class="pl-1">
                  <v-icon v-if="user.facebook_url" small>
                    mdi-facebook
                  </v-icon>
                </v-list-item>
              </v-col>
              <v-col md=1 lg=1 xl=1>
                <v-list-item class="pl-1">
                  <v-icon v-if="user.youtube_url" small>
                    mdi-youtube
                  </v-icon>
                </v-list-item>
              </v-col>
              <v-col md=1 lg=1 xl=1>
                <v-list-item class="pl-1">
                  <v-icon v-if="user.instagram_url" small>
                    mdi-instagram
                  </v-icon>
                </v-list-item>
              </v-col>
            </v-list-item>
            <v-list-item class="mt-n6">
              <h3 style="color:#efeff1">登録日：</h3>
              <h3 class="ml-7" style="color:#efeff1; font-size:0.8rem">{{ joinedTime(user.activated_at) }}</h3>
            </v-list-item>
          </v-sheet>
        </v-col>
        <v-spacer />
        <v-col cols=12 sm=10 md=8 lg=8 xl=8 :class="[$vuetify.breakpoint.mdAndUp ? 'fill-height' : 'mt-n12']">
          <v-btn :class="[$vuetify.breakpoint.mdAndUp ? 'ml-4 mb-1' : 'hidden-xs-only']"
            @click="changeUserComponent(n.name)" v-for="(n, index) in items" :key="index" color="#efeff1" text rounded>
            <div style="color:#efeff1; font-size:0.7rem; font-weight:bold;">{{ n.title }}</div>
          </v-btn>
          <div
            :class="[$vuetify.breakpoint.mdAndUp ? 'hidden-sm-only hidden-md-only hidden-lg-only hidden-xl-only' : 'mb-0']">
            <v-row>
              <v-col cols=1>
                <base-avatar :size="50" :avatar_url="user.avatar_url" />
              </v-col>
              <v-col cols=1 />
              <v-col cols=2>
                <div class="body-2 mt-4 ml-n2">{{ user.username }}</div>
              </v-col>
              <v-col cols=4 />
              <v-col cols=2 class="mt-7 ml-7">
                <v-menu offset-y>
                  <template v-slot:activator="{on, attrs}">
                    <v-btn elevation=0 small width="110" class="rounded-s" style="background-color:#21262d;" dark
                      v-bind="attrs" v-on="on">
                      Filter
                      <v-icon small>mdi-chevron-down</v-icon>
                    </v-btn>
                  </template>
                  <v-list>
                    <v-list-item @click="changeUserComponent(item.name)" class="tile" v-for="(item, n) in items" :key="n">
                      <v-list-item-title>{{ item.title }}</v-list-item-title>
                    </v-list-item>
                  </v-list>
                </v-menu>
              </v-col>
            </v-row>
          </div>
          <v-divider dark />
          <v-row>
            <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
          </v-row>
          <router-view />
        </v-col>
        <v-col cols=1 sm=1 class="hidden-md-only hidden-lg-only hidden-xl-only" />
      </v-row>
    </v-container>
  </div>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios.js';
  import BaseAvatar from '../base/BaseAvatar';
  import UserFollowButton from './UserFollowButton';
  import moment from 'moment';
  const USER_INFO_URL = '/api/v1/users/';

  export default {
    name: 'UserTop',
    components: {
      'base-avatar': BaseAvatar,
      'user-follow-button': UserFollowButton
    },
    data() {
      return {
        justify: [
          'start',
          'center',
          'center',
        ],
        user: '',
        events: [],
        error: '',
        items: {
          Events: {
            title: "Posts",
            name: 'Posts',
            link: ''
          },
          JoinedEvents: {
            title: "Joined",
            name: 'JoinedEvents',
            link: ''
          },
          Activity: {
            title: "Activity",
            name: '',
            link: ''
          },
          Monthly: {
            title: "Recommend",
            name: '',
            link: '',
          },
          Followers: {
            title: "Followers",
            name: 'UserFollowers',
            link: ''
          },
          Following: {
            title: "Follows",
            name: 'UserFollowing',
            link: ''
          },
          About: {
            title: "Profile",
            name: 'About',
            link: ''
          }
        }
      }
    },
    created() {
      document.title = this.$route.name + "- Title"
      this.checkSignedIn()
      this.fetchUserInformation()
    },
    watch: {
      '$route': {
        immediate: true,
        handler(){
          this.fetchUserInformation()
          document.title = this.$route.name + "- Title"
        }
      }
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      fetchUserInformation() {
        secureAxios.get(USER_INFO_URL + `${this.$route.params.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.user = response.data.data.attributes
        this.events = response.data.included
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      },
      joinedTime(time) {
        return moment(time).format("YYYY/MM/DD")
      },
      changeUserComponent(name) {
        this.$router.push({
          name: name
        })
      },
      // filterSearch(name){
      //   this.$router.push({
      //     name: name
      //   })
      // }
    }
  }
</script>

<style scoped>
  h3 {
    font-size: 0.9rem;
  }
</style>