<template>
  <user-card :posts="posts"></user-card>
</template>

<script>
  import { secureAxios } from '../../backend/axios.js'
  import UserCard from '../user/UserCard';

  export default {
    name: "UserCardFilter",
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
        secureAxios.get(this.apiURl(), { params: this.apiParams()})
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.posts = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$router.replace('/')
      },
      apiURl(){
        if(this.$route.name === "Posts" || this.$route.name === "Joined"){
          return '/api/v1/posts/'
        }
      },
      apiParams(){
        var basic_params = { user_id: `${this.$route.params.id}` }
        if(this.$route.name === "Posts"){
          var params = { position: 'my_events' }
          return Object.assign(basic_params, params)
        } else if(this.$route.name === "Joined"){
          var params = { position: 'joined_events' }
          return Object.assign(basic_params, params)
        }
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