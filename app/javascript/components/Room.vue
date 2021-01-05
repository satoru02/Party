<template>
  <div>
    <tbody>
      <tr v-for="(message, index) in realtime_messages" :key="index" :message="message">
        <div>
          <th>{{ message.user }} : {{ message.message }}</th>
        </div>
      </tr>
      <tr v-for="word in messages" :key="word.id" :word="word">
        <th>{{word.user_id}} : {{ word.content }} By Host</th>
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

  const ROOM_URL = '/api/v1/rooms'

  export default {
    name: "Room",
    components: {
      'message': message
    },
    data() {
      return {
        messages: [],
        message: '',
        realtime_messages: [],
        error: ''
      }
    },
    channels: {
      RoomChannel: {
        connected() {},
        rejected() {},
        received(data) {
          this.realtime_messages.push(data)
        },
        disconnected() {}
      }
    },
    mounted() {
      this.$cable.subscribe({
        channel: 'RoomChannel',
        room: "room1"
      })
    },
    created() {
      this.checkSignedIn()
      this.getMessage()
    },
    methods: {
      getMessage() {
        simpleAxios.get(ROOM_URL + `/` + `${this.$route.params.token}` + `/` + `${this.$store.state.currentUser.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.messages = response.data
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
            user_id: `${this.$store.state.currentUser.id}`,
            room_token: `${this.$route.params.token}`,
          }
        })
        this.message = ''
      },
      insertMessage(data) {
        this.message = data['message']
      },
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      }
    }
  }
</script>