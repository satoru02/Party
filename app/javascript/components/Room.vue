<template>
  <v-container class="fill-height pa-1" style="margin-left: 300px;">
    <v-col cols="2" style="max-width: 70%;" class="flex-grow-1 flex-shrink-0 mt-7">
      <v-responsive class="overflow-y-auto fill-height" height="550">
        <v-card color="#161a1d" flat class="fill-height">
          <v-card-text class="flex-grow-1 fill-height">
            <template v-for="word in messages" :word="word">
              <div :key="word.id"
                :class="[ word.user_id === $store.state.currentUser.data.attributes.id ? 'd-flex flex-row-reverse': 'd-flex flex-row']">
                <avatar class="mt-n2" v-if="word.user_id !== $store.state.currentUser.data.attributes.id"
                  :avatar_url="checkAvatar(word.user_id)"></avatar>
                <v-menu offset-y>
                  <template v-slot:activator="{ on }">
                    <v-hover v-slot:default="{ hover }">
                      <v-chip
                        :color="word.user_id === $store.state.currentUser.data.attributes.id ? '#3a36ff': '#212530'"
                        :text-color="word.user_id === $store.state.currentUser.data.attributes.id ? '#ffffff': '#000000'"
                        style="height:auto; min-width:300px; max-width:500px; max-height:1000px; white-space: normal;"
                        class="pa-3 mb-5 mr-5" v-on="on">
                        <p class="ml-2 mt-4" style="font-size: 0.8rem;">{{ word.content }}</p>
                        <p v-if="word.classification === 'join'" class="ml-2 mt-4" style="font-size: 1rem;">
                          {{ word.user }}が、{{ word.created_at }}に参加しました。</p>
                        <v-icon v-if="hover" small></v-icon>
                      </v-chip>
                    </v-hover>
                  </template>
                </v-menu>
              </div>
            </template>
            <template v-for="(message, index) in realtime_messages" :message="message">
              <div :key="index"
                :class="[ message.user_id === $store.state.currentUser.data.attributes.id ? 'd-flex flex-row-reverse': 'd-flex flex-row']">
                <avatar v-if="message.user_id !== $store.state.currentUser.data.attributes.id"></avatar>
                <v-menu offset-y>
                  <template v-slot:activator="{ on }">
                    <v-hover v-slot:default="{ hover }">
                      <v-chip
                        :color="message.user_id === $store.state.currentUser.data.attributes.id ? '#3a36ff': '#212530'"
                        :text-color="message.user_id === $store.state.currentUser.data.attributes.id ? '#ffffff': '#000000'"
                        style="height:auto; min-width:300px; max-width:500px; max-height:1000px; white-space: normal;"
                        class="pa-3 mb-4 mr-5" v-on="on">
                        <p class="ml-2 mt-4" style="font-size: 0.8rem;">{{ message.content }}</p>
                        <p v-if="message.classification === 'join'" class="ml-2 mt-4" style="font-size: 1rem;">
                          {{ message.user }}が、{{ message.time }}に参加しました。</p>
                        <v-icon v-if="hover" small></v-icon>
                      </v-chip>
                    </v-hover>
                  </template>
                </v-menu>
              </div>
            </template>
          </v-card-text>
        </v-card>
      </v-responsive>
      <v-text-field v-model="message" @click:append-outer="sendMessage(message)" append-outer-icon="mdi-send" rounded
        class="mt-16" label="type_a_message" type="text" no-details outlined />
    </v-col>
  </v-container>
</template>

<script>
  import {
    simpleAxios
  } from '../backend/axios.js';
  import consumer from '../channels/consumer.js';
  import message from '../components/Message';
  import Appearance from '../components/Appearance';
  import Avatar from './perpage/TheAvatar';

  const ROOM_URL = '/api/v1/rooms'

  export default {
    name: "Room",
    components: {
      'message': message,
      'appearance': Appearance,
      'avatar': Avatar
    },
    data() {
      return {
        messages: [],
        message: '',
        realtime_messages: [],
        error: '',
        room_users: [],
        avatar: []
      }
    },
    channels: {
      RoomChannel: {
        connected() {},
        rejected() {},
        received(data) {
          if (data.token === `${this.$route.params.token}`) {
            this.realtime_messages.push(data)
          }
        },
        disconnected() {}
      }
    },
    mounted() {
      this.$cable.subscribe({
        channel: 'RoomChannel',
        room: `${this.$route.params.token}`
      })
    },
    created() {
      this.checkSignedIn()
      this.getMessage()
    },
    methods: {
      getMessage() {
        simpleAxios.get(ROOM_URL + `/` + `${this.$route.params.token}` + `/` +
            `${this.$store.state.currentUser.data.attributes.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.messages = response.data.data.attributes.message_info
        this.room_users = response.data.data.attributes.user_info
        this.avatar = response.data.data.attributes.avatar_info
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      sendMessage(message) {
        this.$cable.perform({
          channel: 'RoomChannel',
          action: 'speak',
          data: {
            message: message,
            user_id: `${this.$store.state.currentUser.data.attributes.id}`,
            room_token: `${this.$route.params.token}`,
          }
        })
        this.message = ''
      },
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      checkAvatar(user_id) {
        for (let i = 0; this.avatar.length > i; i++) {
          if (this.avatar[i]["user_id"] === user_id) {
            return this.avatar[i].avatar
          }
        }
      }
    }
  }
</script>

<style>
</style>