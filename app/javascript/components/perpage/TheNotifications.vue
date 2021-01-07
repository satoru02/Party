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
          console.log(data)
          if (this.$store.state.currentUser.id === data["target_user_id"]) {
            this.notifications.push(data)

            // 1.Entryがあった時
            // 2.Entry_Responseがあった時（承認/拒否）
          }
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