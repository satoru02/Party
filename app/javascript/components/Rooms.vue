<template>
  <div>
    <tbody>
      <tr v-for="room in rooms" :key="room.id">
        <router-link :to="{ name: 'Room', params: {token: `${room.resource_token}`} }">
          <th>{{ room.id }}</th>
          <!-- <th>{{ room.name }}</th> -->
        </router-link>
      </tr>
    </tbody>
  </div>
</template>

<script>
  import {
    simpleAxios
  } from '../backend/axios';
  const ROOMS_URL = `/api/v1/rooms`;

  export default {
    name: "Rooms",
    data() {
      return {
        rooms: []
      }
    },
    created() {
      this.getRooms()
    },
    methods: {
      getRooms() {
        simpleAxios.get(ROOMS_URL)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.rooms = response.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
    }
  }
</script>