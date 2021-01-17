<template>
  <div v-bind="user" :key="user.id">
    <avatar :size="27" :avatar_url="user.avatar_url"></avatar>
    <p :name="user.name">{{ user.name }}</p>
    <p :username="user.username">{{ user.username }}</p>
    <p :email="user.email">{{ user.email }}</p>
    <p :about="user.about">{{ user.about }}</p>
    <p :location="user.location">{{ user.location }}</p>
    <p :web_url="user.web_url">{{ user.web_url }}</p>
    <p :youtube_url="user.youtube_url">{{ user.youtube_url }}</p>
    <p :facebook_url="user.facebook_url">{{ user.facebook_url }}</p>
    <p :instagram_url="user.instagram_url">{{ user.instagram_url }}</p>
    <p :filmarks_url="user.filmarks_url">{{ user.filmarks_url }}</p>
    <log></log>
  </div>
</template>

<script>
  import Log from './log.vue'
  import Avatar from '../perpage/TheAvatar'
  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios.js'
  const USER_INFO_URL = '/api/v1/users/'

  export default {
    name: 'User',
    components: {
      'log': Log,
      'avatar': Avatar
    },
    data () {
      return {
        user: '',
        error: ''
      }
    },
    created() {
      this.fecthUserInformation()
    },
    methods: {
      fecthUserInformation() {
        simpleAxios.get(USER_INFO_URL + `${this.$route.params.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.user = response.data.data.attributes
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      }
   }
}
</script>