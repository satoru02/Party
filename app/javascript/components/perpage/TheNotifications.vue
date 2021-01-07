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
        received(data) {
          // 1.Entryがあった時
          // 2.Entry_Responseがあった時（承認/拒否）
          // 3.Messageを受け取った時
          // 4.Notificationが読まれた時

          if (this.$store.state.currentUser.id === data["target_user_id"] && data["condition"] !== "read") {
            this.notifications.push(data)
          } else if(this.$store.state.currentUser.id === data["target_user_id"] && data["condition"] === "read") {
            this.notifications.pop()
          }
        },
        disconnected() {}
      }
    },
    mounted() {
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
        var i = 0;
        var unchecked_notifications = [];
        for (i; i < response.data.length; i++) {
          if (response.data[i].confirmation !== true){
            unchecked_notifications.push(response.data[i])
          }
        }
        this.notifications = unchecked_notifications
      },
      Failed(error) {
        console.log(error)
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>