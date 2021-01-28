<template>
  <div class="text-center">
    <v-row>
      <v-col cols=8 md=2>
        <v-menu open-on-hover offset-y left nudge-height=800 nudge-right="60" nudge-width=150>
          <template v-slot:activator="{ on, attrs }">
            <div v-bind="attrs" v-on="on">
              <v-badge v-if="entryCount(notifications) > 0" color="red" :content="entryCount(notifications)" offset-y="10"
                offset-x="7">
                <router-link to="/notifications">
                  <v-icon class="icon" size=24>mdi-bell-outline</v-icon>
                </router-link>
              </v-badge>
              <router-link to="/notifications">
                <v-icon v-if="entryCount(notifications) === 0" class="icon" size=24>mdi-bell-outline</v-icon>
              </router-link>
            </div>
          </template>
          <v-list class="overflow-y-auto rounded-s" max-height="650" style="background-color:#343a40;">
            <v-list-item v-if="entryCount(notifications) === 0" class="tile">
              <v-list-item-title class="ml-10 mr-10" style="color:#ced4da">現在、新着のお知らせはありません。</v-list-item-title>
            </v-list-item>
            <v-list-item class="tile" v-for="(notification, index) in entryAndResponseNotification(notifications)" :key="index">
              <router-link :to="{ name: 'Notification', params: {id: `${notification.attributes.id }`}}">
                <v-badge dot left inline color="#2176ff">
                  <v-list-item-title v-if="notification.attributes.classification === 'entry'" class="ml-10 mr-10"
                    style="color:#ced4da">あなたのイベントへのエントリーが届きました！</v-list-item-title>
                  <v-list-item-title v-if="notification.attributes.classification === 'entryResponse'"
                    class="ml-10 mr-10" style="color:#ced4da">応募したエントリーの結果が届きました！</v-list-item-title>
                  <v-list-item-action style="color:#6c757d;" v-text="catchedTime(notification.attributes.created_at)">
                  </v-list-item-action>
                </v-badge>
              </router-link>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-col>
      <v-col cols=8 md=3></v-col>
      <v-col cols=8 md=2>
        <v-menu>
          <template v-slot:activator="{on, attrs}">
            <div v-bind="attrs" v-on="on">
              <v-badge color="red" offset-y="10" offset-x="7" v-if="messageCount(notifications) > 0"
                :content="messageCount(notifications)">
                <router-link to="/rooms">
                  <v-icon class="icon mt-1" size=24>mdi-chat-outline</v-icon>
                </router-link>
              </v-badge>
              <router-link to="/rooms">
                <v-icon v-if="messageCount(notifications) === 0" class="icon" size=24>mdi-chat-outline</v-icon>
              </router-link>
            </div>
          </template>
        </v-menu>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import {
    simpleAxios
  } from '../../backend/axios.js'
  import moment from 'moment';
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
          // 3.Messageを受け取った時 -> chat_icon
          // 4.Notificationが読まれた時
          console.log(data)
          if (this.$store.state.currentUser.data.attributes.id === data["target_user_id"] && data["condition"] !== "read") {
            this.notifications.push(data)
          } else if (this.$store.state.currentUser.data.attributes.id === data["target_user_id"] && data["condition"] === "read") {
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
        simpleAxios.get(NOTIFICATIONS_URL, {
            params: {
              position: 'top'
            }
          })
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.notifications = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      catchedTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      },
      messageCount(notifications) {
        if (notifications) {
          var filterd_notifications = notifications.filter(notification => notification.attributes.classification === "message")
          return filterd_notifications.length
        }
      },
      entryCount(notifications) {
        if (notifications) {
          var filterd_notifications = notifications.filter(notification => (notification.attributes.classification === "entry") || (notification.attributes.classification === "entryResponse"))
          return filterd_notifications.length
        }
      },
      entryAndResponseNotification(notifications){
        if (notifications){
          var filterd_notifications = notifications.filter(notification => (notification.attributes.classification === "entry") || (notification.attributes.classification === "entryResponse"))
          return filterd_notifications
        }
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
    background: #6c757d;
  }

  .icon {
    border-radius: 20px;
  }

  .icon:hover {
    background: #495057;
  }
</style>