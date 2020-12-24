<template>
  <div class="users">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <h3>Users</h3>
    <br/>
    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <br />
          <th>Email</th>
          <th>Role</th>
          <th v-if="showPostsLink()">Posts</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in users" :key="user.id" :user="user">
          <th>{{ user.id }}</th>
          <br />
          <td>{{ user.email }}</td>
          <td>{{ user.role }}</td>
          <td v-if="showPostsLink()">
            <router-link :to="`/api/v1/admin/users/${user.id}/posts`">
              <i class="fa fa-list-ul"></i>
            </router-link>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  import { simpleAxios, secureAxios } from '../../../backend/axios.js';
  const ADMIN_USER_URL = '/api/v1/admin/users';

  export default {
    name: 'UsersList',
    data() {
      return {
        error: '',
        users: []
      }
    },
    created () {
      if (this.$store.state.signedIn && (this.$store.getters.isAdmin || this.$store.getters.isManager)) {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.get(ADMIN_USER_URL)
        .then(response => { this.users = response.data })
        .catch(error => { this.setError(error, 'Something went wrong')})
      } else {
        this.$router.replace('/')
      }
    },
    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      showPostsLink() {
        return this.$store.getters.isAdmin
      }
    }
  }
</script>

<style>
 th {
    color: white;
    font-family: 'Open Sans', sans-serif;
    font-size: 20;
    font-weight: bold;
 }

  td {
    color: white;
    font-family: 'Open Sans', sans-serif;
    font-size: 20;
    font-weight: bold;
  }
</style>