<template>
  <div>
    <tbody>
      <tr v-for="word in messages" :key="word.id" :word="word">
        <div id="word">
          <th>{{ word.content }}</th>
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

  const ROOM_URL = '/api/v1/rooms'
  const SUBSCRIBER = consumer.subscriptions.create({
    channel: "RoomChannel",
    room: "room1"
  })
  SUBSCRIBER.received = function (data) {
    const element = document.querySelector('#word')
    element.insertAdjacentHTML('beforeend', data['message'])
  }

  export default {
    name: "Room",
    data() {
      return {
        messages: [],
        message: '',
        error: ''
      }
    },
    created() {
      this.getMessage()
    },
    watched: {},
    methods: {
      getMessage() {
        simpleAxios.get(ROOM_URL)
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
          message: message
        })
      }
    }
  }
</script>