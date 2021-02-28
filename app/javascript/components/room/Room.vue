<template>
  <div>
    <v-row no-gutters>
      <v-col cols=12 sm=12 md=12 lg=12 xl=12>
        <h3>{{ this.$route.params.name }}</h3>
      </v-col>
    </v-row>
    <v-row no-gutters>
      <v-col cols=12 sm=12 md=12 lg=12 xl=12>
        <v-sheet max-height="30" style="background-color:#0e0e10; width:auto;">
          <v-slide-group multiple show-arrows>
            <v-slide-item v-for="n in 5" :key="n">
              <div>
                <base-avatar />
              </div>
            </v-slide-item>
          </v-slide-group>
        </v-sheet>
      </v-col>
    </v-row>
    <!-- #fix -->
    <v-responsive class="overflow-y-auto flex-grow-1 flex-shrink-0 mt-5" height="550">
      <v-container v-for="word in messages" :word="word" :key="word.message.id"
        :class="[ word.message.user_id === $store.state.currentUser.data.attributes.id ? 'd-flex flex-row-reverse': 'd-flex flex-row']">
        <base-avatar class="mt-1 ml-12" v-if="word.message.user_id !== $store.state.currentUser.data.attributes.id" :avatar_url="word.avatar" />
        <v-chip :color="word.message.user_id === $store.state.currentUser.data.attributes.id ? '#212530': '#3a36ff'"
          :text-color="word.message.user_id === $store.state.currentUser.data.attributes.id ? '#ffffff': '#ffffff'"
           class="mr-5"
           :style="$vuetify.breakpoint.mdAndUp ? 'height:auto; min-width:300px; max-width:500px; max-height:3000px; white-space: normal;': 'height:auto; min-width:150px; max-width:300px; max-height:3000px; white-space: normal;'"
          >
          <div style="font-weight:bold;" :class="$vuetify.breakpoint.mdAndUp ? 'ml-2 body-2': 'ml-2 caption'">{{ word.message.content }}</div>
          <div style="font-weight:bold;" :class="$vuetify.breakpoint.mdAndUp ? 'ml-2 body-2': 'ml-2 caption'" v-if="word.message.classification === 'join'" class="ml-2">
            {{ word.user }}が、{{ word.message.created_at }}に参加しました。</div>
        </v-chip>
        <div class="mr-3 mt-16 fill-height" style="max-height:1000px; height:auto; font-size: 0.2rem; color:#6c757d;">
          {{ postedTime(word.message.created_at) }}
        </div>
      </v-container>
    </v-responsive>
    <v-text-field background-color="#212529" v-model="message" @click:append-outer="sendMessage(message)"
      style="bottom:0; width: 100%" append-outer-icon="mdi-send" dense :class="$vuetify.breakpoint.mdAndUp ? 'mt-5 rounded-xl': 'mt-1 rounded-xl'"
      placeholder="メッセージを送信する" type="text" no-details outlined />
  </div>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import RoomAppearance from '../../components/room/RoomAppearance';
  import BaseAvatar from '../base/BaseAvatar';
  import moment from 'moment';
  const ROOM_URL = '/api/v1/rooms'

  export default {
    name: "Room",
    components: {
      'room-appearance': RoomAppearance,
      'base-avatar': BaseAvatar,
    },
    data() {
      return {
        room_token: '',
        messages: [],
        message: '',
        error: '',
        room_users: [],
        avatar: [],
      }
    },
    created() {
      document.title = this.$route.params.name + " - Plaza"
      this.checkSignedIn()
    },
    watch: {
      '$route.query': {
        immediate: true,
        handler() {
          this.createCable()
          this.getMessage()
          document.title = this.$route.params.name + " - Plaza"
        }
      }
    },
    channels: {
      RoomChannel: {
        connected() {},
        rejected() {},
        received(data) {
          if ((data["token"] === this.room_token) && (data["token"] === `${this.$route.params.token}`)) {
            // #fix
            this.messages.push({message: data, avatar: data["avatar"]})
          }
        },
        disconnected() {}
      }
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      createCable() {
        this.$cable.subscribe({
          channel: 'RoomChannel',
          room: `${this.$route.params.token}`
        })
      },
      getMessage() {
        secureAxios.get(ROOM_URL + `/` + `${this.$route.params.token}` + `/` +
            `${this.$store.state.currentUser.data.attributes.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.room_token = response.data.data.attributes.resource_token
        this.messages = response.data.data.attributes.message_info
        this.room_users = response.data.data.attributes.user_info
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      sendMessage(message) {
        if (message) {
          this.$cable.perform({
            channel: 'RoomChannel',
            action: 'speak',
            data: {
              message: message,
              user_id: `${this.$store.state.currentUser.data.attributes.id}`,
              room_token: `${this.$route.params.token}`,
            }
          })

        }
        this.message = ''
      },
      postedTime(message) {
        moment.locale('ja')
        return moment(message).format("MMMDo(dd) h:mm")
      }
    }
  }
</script>