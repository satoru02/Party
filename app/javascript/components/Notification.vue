<template>
  <div>
    <tr id="post-content">
      <th>{{ post_information.title }}</th>
    </tr>
    <tr id="user-content">
      <th>{{ user_information.email }}</th>
    </tr>
    <v-btn text color="primary" @click="authorizeEntry()">
      Authorize
    </v-btn>
    <v-btn text color="primary" @click="declineEntry()">
      Decline
    </v-btn>
  </div>
</template>

<script>
  // 1. Entry request
  // 2. Entry approved
  // 3. Entry declined

  import {
    simpleAxios,
    secureAxios
  } from "../backend/axios"
  const NOTIFICATION_URL = `/api/v1/notifications`
  const ENTRY_AUTHORIZATION_URL = `/api/v1/rooms_user`

  export default {
    name: 'Notification',
    data() {
      return {
        post_information: '',
        user_information: '',
      }
    },
    created() {
      this.getNotification()
    },
    methods: {
      getNotification() {
        simpleAxios.get(NOTIFICATION_URL + `/` + `${this.$route.params.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.post_information = response.data[0].Filtered_Post
        this.user_information = response.data[0].Filtered_User
      },
      Failed() {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      authorizeEntry() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        // secureAxios.post(ENTRY_AUTHORIZATION_URL,{
        // })
      },
      declineEntry() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
      }
    }
  }
</script>