<template>
</template>

<script>
  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios';
  const ACTIVATION_URL = '/api/v1/account_activations';
  const USER_INFO_URL = '/api/v1/users/me';

  export default {
    name: 'AccountActivation',
    created() {
      this.checkSignedIn()
      secureAxios.post(ACTIVATION_URL + `/` + `${this.$route.params.token}`)
        .then(response => this.activationSuccessful(response))
        .catch(error => this.activationFailed(error))
    },
    updated() {
      this.checkSignedIn()
    },
    methods: {
      activationSuccessful(response) {
        if (!response.data.csrf) {
          this.Failed(response)
          return
        }
        simpleAxios.defaults.headers.common['Authorization'] = `Bearer ${response.data.access_token}`
        simpleAxios.get(USER_INFO_URL, {
            params: {
              position: 'activation'
            }
          })
          .then(me_response => {
            this.$store.commit('setCurrentUser', {
              currentUser: me_response.data,
              csrf: response.data.csrf,
              token: response.data.access_token
            })
            this.error = ''
            this.$router.replace({
              name: "InitialSettings"
            })
          })
          .catch(error => this.signupFailed(error))
      },
      activationFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$store.commit('unsetCurrentUser')
      },
      checkSignedIn() {
        if (this.$store.state.signedIn) {
          this.$router.replace('/')
        }
      }
    }
  }
</script>