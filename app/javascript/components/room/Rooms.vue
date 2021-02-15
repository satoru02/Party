<template>
  <v-container fluid>
    <v-row>
      <v-col lg=3 xl=4>
        <v-list-item two-line class="tile" v-for="room in rooms" :key="room.id"
          @click="moveRoom(room), checkConfirmation(room)">
          <v-list-item-icon>
            <base-avatar />
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>{{ room.attributes.name }}</v-list-item-title>
            <v-list-item-subtitle class="room_message">{{ room.attributes.latest_message.content }}
            </v-list-item-subtitle>
          </v-list-item-content>
          <v-list-item-action>
            <v-list-item-action-text>
              {{ postTime(room.attributes.latest_message.created_at) }}
            </v-list-item-action-text>
            <!-- <v-icon> -->
              <v-badge left v-if="room.attributes.latest_message.confirmation === false" dot color="#2176ff" />
            <!-- </v-icon> -->
          </v-list-item-action>
        </v-list-item>
      </v-col>
      <v-col lg=9 xl=9>
        <router-view />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseAvatar from '../base/BaseAvatar';
  import Room from './Room';
  import moment from 'moment';

  const ROOMS_URL = `/api/v1/rooms`;

  export default {
    name: "Rooms",
    components: {
      'base-avatar': BaseAvatar,
      'room': Room
    },
    data() {
      return {
        rooms: [],
      }
    },
    created() {
      this.checkSignedIn()
      this.getRooms()
    },
    channels: {
      RoomsChannel: {
        connected() {},
        rejected() {},
        received(data) {
          let filtered_room = this.rooms.filter(room => room.attributes.resource_token === data["token"])
          filtered_room[0].attributes.latest_message.content = data["content"]
          filtered_room[0].attributes.latest_message.created_at = data["time"]
          if (this.$route.params.token !== filtered_room[0].attributes.resource_token) {
            filtered_room[0].attributes.latest_message.confirmation = false
          }
        },
        disconnected() {}
      }
    },
    mounted() {
      this.$cable.subscribe({
        channel: 'RoomsChannel',
      })
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      getRooms() {
        secureAxios.get(ROOMS_URL)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.rooms = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      checkAvatar(host_id, room_avatar) {
        for (let i = 0; room_avatar.length > i; i++) {
          if (room_avatar[i]["user_id"] === host_id) {
            return room_avatar[i].avatar
          }
        }
      },
      postTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      },
      checkConfirmation(room) {
        room.attributes.latest_message.confirmation = true
      },
      moveRoom(room) {
        this.$router.push({
          name: 'Room',
          params: {
            name: room.attributes.name,
            token: room.attributes.resource_token
          }
        })
      }
    }
  }
</script>

<style>
  .room_message {
    font-size: 9px;
    color: gray;
    margin-top: 15px;
  }

  .room_lasttime {
    font-size: 11px;
    color: gray;
    margin-top: 4px;
  }

  .tile {
    margin: 6px;
    border-radius: 7px;
  }

  .tile:hover {
    background: #212529;
  }
</style>

<!-- <avatar :avatar_url="checkAvatar(room.attributes.host_id, room.attributes.avatar_info)" class="mt-n1"></avatar> -->