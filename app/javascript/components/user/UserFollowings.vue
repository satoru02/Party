<template>
  <user-relationships
    :relationships="followingUsers"
   />
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  import UserRelationships from './UserRelationships';
  const  FOLLOWING_URL = '/api/v1/users/';

  export default {
    name: "Followings",
    components: {
      'user-relationships': UserRelationships
    },
    data() {
      return {
        followingUsers: []
      }
    },
    created() {
      this.fetchFollowingUsers()
    },
    methods: {
      fetchFollowingUsers(){
        secureAxios.get(FOLLOWING_URL + `${this.$route.params.id}` + `/following`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.followingUsers = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>