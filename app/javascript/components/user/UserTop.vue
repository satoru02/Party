<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols=12 />
      </v-row>
      <v-row>
        <v-col cols=12 md=3 class="ml-16">
          <avatar
            :size="140"
            :avatar_url="user.avatar_url" />
        </v-col>
        <v-col cols=12 md=auto class="ml-n3">
          <v-btn
            v-for="(n, index) in items"
            :key="index"
            color="#efeff1"
            text
            rounded
            class="my-2 mt-8">
            <router-link :to="{ name: n.name }">
              <div style="color:#efeff1; font-size:0.7rem;">{{ n.title }}</div>
            </router-link>
          </v-btn>
          <v-divider
            dark
            class="mt-n1" />
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=3 class="ml-n2 mt-2">
          <v-sheet
            color="#121212"
            class="rounded-lg"
            style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 180px; max-width: 100%; max-height:1000px;">
            <h1 class="ml-3 mb-2 mt-2">@{{ user.username }}</h1>
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
              <v-col cols=5 md=1>
                <v-list-item class="pl-1">
                  <v-icon
                    v-if="user.facebook_url"
                    small>
                    mdi-facebook
                  </v-icon>
                </v-list-item>
              </v-col>
              <v-col cols=5 md=1>
                <v-list-item class="pl-1">
                  <v-icon
                    v-if="user.youtube_url"
                    small>
                    mdi-youtube
                  </v-icon>
                </v-list-item>
              </v-col>
              <v-col cols=5 md=1>
                <v-list-item class="pl-1">
                  <v-icon
                    v-if="user.instagram_url"
                    small>
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
        <v-col cols=12 md=8 class="mt-n16 ml-12">
          <router-view />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
  import { secureAxios } from '../../backend/axios.js'
  import Avatar from '../page/TheAvatar'
  import moment from 'moment';
  const USER_INFO_URL = '/api/v1/users/'

  export default {
    name: 'User',
    components: {
      'avatar': Avatar,
    },
    data() {
      return {
        user: '',
        events: [],
        error: '',
        items: {
          Events: {
            title: "主催イベント",
            name: 'MyEvents',
            link: ''
          },
          JoinedEvents: {
            title: "参加イベント",
            name: 'JoinedEvents',
            link: ''
          },
          Activity: {
            title: "アクティビティ",
            name: '',
            link: ''
          },
          Monthly: {
            title: "レコメンド",
            name: '',
            link: '',
          },
          Followers: {
            title: "フォロワー",
            name: '',
            link: ''
          },
          Following: {
            title: "フォロー",
            name: '',
            link: ''
          },
          About: {
            title: "プロフィール",
            name: 'About',
            link: ''
          }
        }
      }
    },
    created(){
      this.checkSignedIn()
      this.fetchUserInformation()
    },
    watch: {
      '$route': 'fetchUserInformation'
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
      }
    }
  }
</script>

<style scoped>
</style>