<template>
  <div>
    <tbody>
      <tr v-for="word in messages" :key="word.id" :word="word">
        <div id="word">
            <th>{{word.user_id}} : {{ word.content }} By Host</th>
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

  const ROOM_URL = '/api/v1/rooms'
  const SUBSCRIBER = consumer.subscriptions.create({
    channel: "RoomChannel",
    room: "room1"
  })
  SUBSCRIBER.received = function (data) {
    const html = `
      <th>${data["user"]}:   ${data["message"]}</th>
    `
    const element = document.querySelector('#word')
    element.insertAdjacentHTML('beforeend', html)
  }

  export default {
    name: "Room",
    components: {
      'message': message
    },
    data() {
      return {
        messages: [],
        message: '',
        error: ''
      }
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
        SUBSCRIBER.perform('speak', {
          message: message,
          user_id: `${this.$store.state.currentUser.id}`,
          room_token: `${this.$route.params.token}`,
        })
        this.message = ''
      },
      insertMessage(data) {
        this.message = data['message']
      },
      checkSignedIn() {
        if(!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      }
    }
  }
</script>