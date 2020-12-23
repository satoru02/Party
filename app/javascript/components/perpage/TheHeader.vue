<template>
  <v-app-bar app color="black">
    <v-container>
      <v-row class="d-flex justify-space-around mb-6">
        <v-col class="pa-2 mt-13">
          <router-link to="/">
            <h3 style="color:white">LAPLACE</h3>
          </router-link>
        </v-col>
        <v-spacer></v-spacer>
        <v-col class="pa-2 mt-10">
          <v-text-field></v-text-field>
        </v-col>
        <v-spacer></v-spacer>
        <v-col class="pa-2 mt-14 ml-n16 ">
          <v-icon>mdi-menu</v-icon>
        </v-col>
        <v-col class="pa-2 mt-14 ml-n16 ">
          <v-icon v-if="showAdminLink()">mdi-wifi</v-icon>
        </v-col>
        <v-col class="pa-2 mt-14 ml-n16 ">
          <v-icon @click="signOut">mdi-wifi</v-icon>
        </v-col>
        <v-col class="pa-2 mt-10">
          <avatar></avatar>
        </v-col>
      </v-row>
    </v-container>
  </v-app-bar>
</template>

<script>
  import Avatar from './TheAvatar.vue';
  import axios from 'axios';

  const LOGOUT_URL = '/api/v1/login';
  const signoutAxios = axios.create({
  withCredential: true,
  headers: {
    'Content-Type': 'application/json'
  }
  });

  export default {
    name: 'top-header',
    components: {
      'avatar': Avatar,
    },
    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      signOut () {
        signoutAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        signoutAxios.delete(LOGOUT_URL + `/` + `${this.$store.state.currentUser.id}`)
        .then(response => {
          this.$store.commit('unsetCurrentUser')
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
      },
      showAdminLink() {
        return this.$store.getters.isAdmin || this.$store.getters.isManager
      }
    }
  }
</script>

