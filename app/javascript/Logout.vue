<template>
</template>

<script>
import { secureAxios } from './backend/axios';
const LOGOUT_URL = "/api/v1/login"

export default {
  name: 'Logout',
  created(){
    this.logout()
  },
  methods:{
    logout(){
      secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
      secureAxios.delete(LOGOUT_URL + `/` + `${this.$store.state.currentUser.data.attributes.id}`)
       .then(res => this.logoutSuccessful(res))
       .catch(error => this.setError(error, 'Cannot log out.'))
    },
    logoutSuccessful(res){
      localStorage.removeItem('vuex')
      this.$store.commit('unsetCurrentUser')
      this.$router.replace('/')
    }
  }
}
</script>