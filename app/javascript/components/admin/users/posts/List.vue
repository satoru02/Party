<template>
  <div class="users">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <h3>User Posts</h3>
    <br />

    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>User ID</th>
          <th>Title</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="post in posts" :key="post.id" :post="post">
          <th>{{ post.id }}</th>
          <th>{{ post.user_id }}</th>
          <th>{{ post.title }}</th>
        </tr>
      </tbody>
    </table>

  </div>
</template>

<script>
  import axios from 'axios'

  const ADMIN_USERS_POST_URL = '/api/v1/admin/users';
  const adminAxios = axios.create({
  withCredential: true,
  headers: {
    'Content-Type': 'application/json'
  }
  });

export default {
  name: "UserPostsList",
  data () {
    return {
      error: '',
      posts: []
    }
  },
  created () {
    if (this.$store.state.signedIn && this.$store.getters.isAdmin) {
      adminAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
      adminAxios.get(ADMIN_USERS_POST_URL + `/` + `${this.$route.params.id}` + `/posts`)
       .then(response => { this.posts = response.data })
       .catch(error => { this.setError(error, "Something went wrong") })
    } else {
      this.$route.replace('/')
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}
</script>