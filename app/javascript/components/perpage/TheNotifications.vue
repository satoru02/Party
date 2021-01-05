<template>
  <v-col id="count" class="pa-2 mt-14 ml-n16" v-model="this.notifications.length">
    <th>{{ notifications.length }}</th>
  </v-col>
</template>

<script>
  import {
    simpleAxios
  } from '../../backend/axios.js'
  const NOTIFICATIONS_URL = '/api/v1/notifications'

  export default {
    name: 'Notifications',
    data() {
      return {
        notifications: [],
      }
    },
    channels: {
      NotificationsChannel: {
        connected() {},
        rejected() {},
        // SUBSCRIBER receive
        received(data) {
          // fix beacause object type is defferent
          this.notifications.push(data)
        },
        disconnected() {}
      }
    },
    mounted() {
      // make SUBSCRIBER
      this.$cable.subscribe({
        channel: 'NotificationsChannel'
      })
    },
    created() {
      this.getNotifications()
    },
    methods: {
      getNotifications() {
        simpleAxios.get(NOTIFICATIONS_URL)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.notifications = response.data
      },
      Failed(error) {
        console.log(error)
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>