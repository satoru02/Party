<template>
  <v-col id="icon" class="pa-2 mt-14 ml-n16" :notifications="this.notifications">
    <v-icon>mdi-wifi</v-icon>
    <th>{{ notifications.length }}</th>
  </v-col>
</template>

<script>
  import consumer from '../../channels/consumer.js';
  import {
    simpleAxios
  } from '../../backend/axios.js'
  const NOTIFICATIONS_URL = '/api/v1/notifications'

  const SUBSCRIBER = consumer.subscriptions.create({
    channel: "NotificationsChannel",
  })

  SUBSCRIBER.received = function (data) {
    console.log(data)
    // vueにアクセスしたい。
  }

  export default {
    name: 'Notifications',
    data() {
      return {
        notifications: []
      }
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