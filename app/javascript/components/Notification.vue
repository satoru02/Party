<template>
  <div>
    <tr id="post-content">
      <th>{{ requested_post_information.title }}</th>
    </tr>
    <tr id="user-content">
      <th>{{ requested_user_information.email }}</th>
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
  // 動的vue-routing
  // // 1. Entry request
  //    entry_notification_component
  // // 2. Entry approved
  //    entry_approved_component
  // // 3. Entry declined
  //    entry_declined_component

  import {
    simpleAxios,
    secureAxios
  } from "../backend/axios"
  const NOTIFICATION_URL = `/api/v1/notifications`
  const ENTRY_URL = `/api/v1/rooms_user`

  export default {
    name: 'Notification',
    data() {
      return {
        requested_entry_information: '',
        requested_post_information: '',
        requested_user_information: '',
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
        this.requested_entry_information = response.data[0].Entry
        this.requested_post_information = response.data[0].Post
        this.requested_user_information = response.data[0].User
      },
      Failed() {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      authorizeEntry() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(ENTRY_URL, {
            answer: 'authorize',
            entry_id: this.requested_entry_information.id,
            post_id: this.requested_post_information.id,
            user_id: this.requested_user_information.id
          })
          .catch(error => this.Failed(error))
      },
      declineEntry() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(ENTRY_URL, {
            answer: 'decline',
            entry_id: this.requested_entry_information.id,
            post_id: this.requested_post_information.id,
            user_id: this.requested_user_information.id
          })
          .catch(error => this.Failed(error))
      }
    }
  }
</script>