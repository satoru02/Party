<template>
</template>

<script>
import { simpleAxios,secureAxios } from './backend/axios.js'
const ACTIVATION_URL = '/api/v1/account_activations'
const USER_INFO_URL = '/api/v1/users/me'

export default {
  name: 'Activation',
  created() {
    this.checkSignedIn()
    secureAxios.post(ACTIVATION_URL + `/` + `${this.$route.params.token}`)
    .then(response => this.activationSuccessful(response))
    .catch(error => this.activationFailed(error))
  },
  updated(){
    this.checkSignedIn()
  },
  methods: {
    activationSuccessful(response) {
      if(!response.data.csrf) {
        this.Failed(response)
        return
      }
      simpleAxios.get(USER_INFO_URL,{
        params: {
          position: 'activation'
        }
      })
        .then(me_response => {
          this.$store.commit('setCurrentUser', {
            currentUser: me_response.data,
            csrf: response.data.csrf
          })
          this.error = ''
          this.$router.replace('/initial-settings')
        })
      .catch(error => this.signupFailed(error))
     },
     activationFailed(error) {
       this.error = (error.response && error.response.data && error.response.data.error) || ""
       this.$store.commit('unsetCurrentUser')
     },
     checkSignedIn(){
       if(this.$store.state.signedIn){
         this.$router.replace('/')
       }
     }
  }
}
</script>