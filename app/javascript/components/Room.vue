<template>
  <div>
    <div id="member" v-for="member in room_users" :key="member.id" :member="member">
       <appearance></appearance>
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
    </tbody>
    <form class="form-message" @submit.prevent="sendMessage(message)">
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <label>Say Something</label>
      <input v-model="message" type="text" class="form-control" id="message">
      <button type="submit" class="btn btn-primary mb-3">send</button>
    </form>
  </div>
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
          if (data.token === `${this.$route.params.token}`){
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
        simpleAxios.get(ROOM_URL + `/` + `${this.$route.params.token}` + `/` + `${this.$store.state.currentUser.data.attributes.id}`)
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