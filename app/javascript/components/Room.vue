<template>
  <v-container class="fill-height pa-1" style="margin-left: 300px;">
    <!-- <div id="member" v-for="member in room_users" :key="member.id" :member="member">
        {{ member.email }}
      </div>
      <tbody>
        <tr v-for="word in messages" :key="word.id" :word="word">
          <th>{{word.user_id}} : {{ word.content }} By Host</th>
          <th v-if="word.classification === 'join'">{{word.user_id}}が{{ word.created_at}}に参加しました。</th>
        </tr>
        <tr v-for="(message, index) in realtime_messages" :key="index" :message="message">
          <div>
            <th>{{ message.user }} : {{ message.message }}</th>
            <th v-if="message.classification === 'join'">{{ message.user }}が、{{ message.time}}参加しました。</th>
          </div>
        </tr>
      </tbody> -->
    <!-- <form class="form-message" @submit.prevent="sendMessage(message)">
        <div class="alert alert-danger" v-if="error">{{ error }}</div>
        <label>Say Something</label>
        <input v-model="message" type="text" class="form-control" id="message">
        <button type="submit" class="btn btn-primary mb-3">send</button>
      </form> -->

    <v-col cols="2" style="max-width: 70%;" class="flex-grow-1 flex-shrink-0 mt-7">
      <v-responsive class="overflow-y-auto fill-height" height="550">
        <v-card color="#161a1d" flat class="fill-height">
          <v-card-text class="flex-grow-1 fill-height">
            <template v-for="word in messages" :word="word">
              <div :key="word.id" :class="[ word.user_id === $store.state.currentUser.data.attributes.id ? 'd-flex flex-row-reverse': 'd-flex flex-row']">
                <v-menu offset-y>
                  <template v-slot:activator="{ on }">
                    <v-hover v-slot:default="{ hover }">
                      <v-chip
                        :color="word.user_id === $store.state.currentUser.data.attributes.id ? '#3a36ff': '#cbd1da'"
                        :text-color="word.user_id === $store.state.currentUser.data.attributes.id ? '#ffffff': '#000000'"
                        style="height:auto; min-width:300px; max-width:500px; max-height:1000px; white-space: normal;" class="pa-3 mb-4" v-on="on">
                        <p class="ml-2 mt-4" style="font-size: 0.8rem;">{{ word.content }}</p>
                        <!-- <sub class="ml-2" style="font-size: 0.2rem;">{{ word.created_at }}</sub> -->
                        <v-icon v-if="hover" small>expand_more</v-icon>
                      </v-chip>
                    </v-hover>
                  </template>
                </v-menu>
              </div>
            </template>
          </v-card-text>
        </v-card>
      </v-responsive>
      <v-text-field rounded class="mt-16" label="type_a_message" type="text" no-details outlined />
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

  const ROOM_URL = '/api/v1/rooms'

  export default {
    name: "Room",
    components: {
      'message': message,
      'appearance': Appearance
    },
    data() {
      return {
        messages: [],
        message: '',
        realtime_messages: [],
        error: '',
        room_users: [],
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
      }
    }
  }
</script>

<style>
  /* .room {
    display: grid;
    grid-template-columns: auto auto;
    grid-template-areas: "left right";
  } */
</style>