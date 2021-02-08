<template>
  <div class="text-center">
    <v-row>
      <v-col cols=8 md=2>
        <v-menu open-on-hover offset-y left nudge-height=800 nudge-right="60" nudge-width=150>
          <template v-slot:activator="{ on, attrs }">
            <div v-bind="attrs" v-on="on">
              <v-badge v-if="entryNotifications.length > 0" color="red" :content="entryNotifications.length" offset-y="10"
                offset-x="7">
                <router-link to="/notifications">
                  <v-icon class="icon" size=24>mdi-bell-outline</v-icon>
                </router-link>
              </v-badge>
              <router-link to="/notifications">
                <v-icon v-if="entryNotifications.length === 0" class="icon" size=24>mdi-bell-outline</v-icon>
              </router-link>
            </div>
          </template>
          <v-list class="overflow-y-auto rounded-s" max-height="650" style="background-color:#343a40;">
            <v-list-item v-if="entryNotifications.length === 0" class="tile">
              <v-list-item-title class="ml-10 mr-10" style="color:#ced4da">現在、新着のお知らせはありません。</v-list-item-title>
            </v-list-item>
            <v-list-item class="tile" v-for="(notification, index) in entryNotifications" :key="index">
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
              <v-badge color="red" offset-y="10" offset-x="7" v-if="messageNotifications.length > 0" :content="messageNotifications.length">
                <router-link to="/rooms">
                  <v-icon class="icon mt-1" size=24>mdi-chat-outline</v-icon>
                </router-link>
              </v-badge>
              <router-link to="/rooms">
                <v-icon v-if="messageNotifications.length === 0" class="icon" size=24>mdi-chat-outline</v-icon>
              </router-link>
            </div>
          </template>
        </v-menu>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import { secureAxios } from '../../backend/axios.js'
  import moment from 'moment';
  const NOTIFICATIONS_URL = '/api/v1/notifications'

  export default {
    name: 'NotificationMenu',
    data() {
      return {
        entryNotifications: [],
        messageNotifications: []
      }
    },
    channels: {
      NotificationsChannel: {
        connected() {},
        rejected() {},
        received(data) {
          // 1.Entry is catched.
          // 2.EntryResponse is catched（authorization/decline）.
          // 3.Message is catched.
          // 4.Notification is readen.

          if(this.$store.state.currentUser.data.attributes.id === data["target_user_id"]) {
            if(((data.attributes.classification === "entry") || (data.attributes.classification === "entryResponse")) && data["condition"] !== "read" ){
              this.entryNotifications.push(data)
            } else if((data.attributes.classification === "message") && (data.attributes.confirmation === false) && (data.message_confirmation === false)) {
              this.messageNotifications.push(data)
            } else if((data.attributes.classification === "message") && (data.message_confirmation === true)){
              this.messageNotifications = this.messageNotifications.filter(notification => notification.attributes.id !== data.attributes.id)
            } else if(data["condition"] === "read") {
              this.entryNotifications.pop()
            }
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
        secureAxios.get(NOTIFICATIONS_URL, {
            params: {
              position: 'top'
            }
          })
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.entryNotifications = response.data.data.filter(data => (data.attributes.classification === "entry") || (data.attributes.classification === "entryResponse"))
        this.messageNotifications = response.data.data.filter(data => data.attributes.classification === "message")
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      catchedTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
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