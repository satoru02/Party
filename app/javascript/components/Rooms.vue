<template>
  <div class="rooms" >
    <div class="group">
      <v-list color="#161a1d">
        <v-list-item class="tile" v-for="room in rooms" :key="room.id">
          <v-list-item-icon>
            <!-- <avatar :avatar_url="checkAvatar(room.attributes.host_id, room.attributes.avatar_info)" class="mt-n1"></avatar> -->
          </v-list-item-icon>
          <v-list-item-content class="ml-n9">
            <router-link @click.native="checkConfirmation(room)" :to="{ name: 'Room', params: {name: `${room.attributes.name}`, token: `${room.attributes.resource_token}`} }">
              <v-row no-gutters>
                <v-col class="d-flex" md="9" offset-md="n1">
                  <v-list-item-subtitle>{{ room.attributes.name }}</v-list-item-subtitle>
                </v-col>
                <v-col class="d-flex mb-n6 mr-n8" md="1" offset-md="2" v-if="room.attributes.latest_message">
                  <p class="room_lasttime">{{ postTime(room.attributes.latest_message.created_at) }}</p>
                </v-col>
              </v-row>
              <v-row no-gutters>
                <v-col class="d-flex" md="7" offset-md="n2" v-if="room.attributes.latest_message">
                  <p class="room_message">{{ room.attributes.latest_message.content }}</p>
                </v-col>
                <v-col class="d-flex mt-7" md="1" offset-md="2" v-if="room.attributes.latest_message.confirmation === false">
                  <v-badge dot left inline color="#2176ff"></v-badge>
                </v-col>
              </v-row>
            </router-link>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { secureAxios } from '../backend/axios';
  import Avatar from '../components/perpage/TheAvatar';
  import Room from '../components/Room';
  import moment from 'moment';

  const ROOMS_URL = `/api/v1/rooms`;

  export default {
    name: "Rooms",
    components: {
      'avatar': Avatar,
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
        connected(){},
        rejected(){},
        received(data){
          console.log(data)
          var filtered_room = this.rooms.filter(room => room.attributes.resource_token === data["token"])
          filtered_room[0].attributes.latest_message.content = data["content"]
          filtered_room[0].attributes.latest_message.created_at = data["time"]
          if (this.$route.params.token !== filtered_room[0].attributes.resource_token ){
            filtered_room[0].attributes.latest_message.confirmation = false
          }
        },
        disconnected(){}
      }
    },
    mounted(){
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
      checkConfirmation(room){
        room.attributes.latest_message.confirmation = true
      }
    }
  }
</script>

<style>
  .rooms {
    display: grid;
    grid-template-columns: 364px auto;
    grid-template-areas: "group room";
  }

  .room {
    position: sticky;
    top: 0;
    height: 100vh;
  }

  .room_message {
    font-size: 11px;
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