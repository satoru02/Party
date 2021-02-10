<template>
  <user-relationships
    :relationships="followerUsers"
   />
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  import UserRelationships from './UserRelationships';
  const  FOLLOWER_URL = '/api/v1/users/';

  export default {
    name: "UserFollowers",
    components: {
      'user-relationships': UserRelationships
    },
    data() {
      return {
        followerUsers: []
      }
    },
    created() {
      this.fetchFollowerUsers()
    },
    methods: {
      fetchFollowerUsers(){
        secureAxios.get(FOLLOWER_URL + `${this.$route.params.id}` + `/followers`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.followerUsers = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>