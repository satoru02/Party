<template>
  <user-card :posts="rooms"></user-card>
</template>

<script>
  import UserCard from '../user/userCard';
  import { secureAxios } from '../../backend/axios.js'
  const USERS_POST_INFO_URL = '/api/v1/posts/'

  export default {
    name: "JoinedEvent",
    components: {
      'user-card': UserCard
    },
    data() {
      return {
        rooms: []
      }
    },
    created() {
      this.fetchJoinedPost()
    },
    methods: {
      fetchJoinedPost() {
        secureAxios.get(USERS_POST_INFO_URL, {
            params: {
              user_id: `${this.$route.params.id}`,
              position: 'joined_events'
            }
          })
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.rooms = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      }
    }
  }
</script>