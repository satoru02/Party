<template>
  <!-- 未読通知のリアルタイムカウント -->
  <!-- <v-col id="count" class="pa-2 mt-14 ml-n16" v-model="this.notifications.length">
    <th>{{ notifications.length }}</th>
  </v-col> -->

  <div class="text-center">
    <!-- <v-icon v-model="this.notifications.length" class="mt-4 mr-16" size=3>{{ notifications.length }}</v-icon> -->
    <v-menu open-on-hover offset-y left nudge-height=600 nudge-width=130>
      <template v-slot:activator="{ on, attrs }">
        <div v-bind="attrs" v-on="on">
          <v-icon class="mt-4 mr-16" size=23>mdi-bell-outline</v-icon>
        </div>
      </template>
      <v-list class="overflow-y-auto rounded-lg" max-height="400" style="background-color:#343a40;">
        <v-list-item class="tile" v-for="(notification, index) in notifications" :key="index">
          <router-link :to="{ name: 'Notification', params: {id: `${notification.id }`}}">
            <v-list-item-title style="color:#ced4da">{{ notification.id }}</v-list-item-title>
          </router-link>
        </v-list-item>
      </v-list>
    </v-menu>
  </div>
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

<style scoped>
  .tile {
    margin: 10px;
    border-radius: 7px;
  }

  .tile:hover {
    background: #2d00f7;
  }
</style>