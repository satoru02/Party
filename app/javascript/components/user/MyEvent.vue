<template>
 <user-card :posts="posts"></user-card>
</template>

<script>
  import { secureAxios } from '../../backend/axios.js'
  import UserCard from '../user/userCard';
  const USERS_POST_INFO_URL = '/api/v1/posts/'

  export default {
    name: "MyEvent",
    components: {
      'user-card': UserCard
    },
    data() {
      return {
        posts: [],
      }
    },
    created() {
      this.fetchUsersPost()
    },
    watch: {
      '$route': 'fetchUsersPost'
    },
    methods: {
      fetchUsersPost() {
        secureAxios.get(USERS_POST_INFO_URL, {
            params: {
              user_id: `${this.$route.params.id}`,
              position: 'my_events'
            }
          })
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.posts = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
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
    background: #6c757d;
  }
</style>