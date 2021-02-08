<template>
  <div class="room">
    <v-row>
      <v-col cols=12 md=12 class="ml-10 mt-3">
        <h2>{{ this.$route.params.name }}</h2>
      </v-col>
      </v-row>
    <v-row class="mt-2">
      <v-col cols=12 md=12 class="mt-n7">
        <v-sheet max-width="1000" max-height="30" style="background-color:#161a1d;" class="ml-11">
        <v-slide-group multiple show-arrows>
          <v-slide-item v-for="n in 5" :key="n">
            <div>
              <avatar :size="30"></avatar>
            </div>
          </v-slide-item>
        </v-slide-group>
        </v-sheet>
      </v-col>
    </v-row>
    <v-responsive class="overflow-y-auto flex-grow-1 flex-shrink-0 mt-5" style="max-width: 93%;" height="550">
        <v-container v-for="word in messages" :word="word" :key="word.id"
          :class="[ word.user_id === $store.state.currentUser.data.attributes.id ? 'd-flex flex-row-reverse': 'd-flex flex-row']">
          <!-- <avatar class="mt-1 ml-12" v-if="word.user_id !== $store.state.currentUser.data.attributes.id"
            :avatar_url="checkAvatar(word.user_id)"></avatar> -->
          <v-chip :color="word.user_id === $store.state.currentUser.data.attributes.id ? '#3a36ff': '#212530'"
            :text-color="word.user_id === $store.state.currentUser.data.attributes.id ? '#ffffff': '#000000'"
            style="height:auto; min-width:300px; max-width:500px; max-height:3000px; white-space: normal;"
            class="mr-5">
            <p class="ml-2 mt-4" style="font-size: 0.8rem;">{{ word.content }}</p>
            <p v-if="word.classification === 'join'" class="ml-2 mt-4" style="font-size: 1rem;">
              {{ word.user }}が、{{ word.created_at }}に参加しました。</p>
          </v-chip>
          <div class="mr-3 mt-16 fill-height" style="max-height:1000px; height:auto; font-size: 0.2rem; color:#6c757d;">
            {{ postedTime(word.created_at) }}
          </div>
        </v-container>
    </v-responsive>
    <v-text-field background-color="#0b090a" v-model="message" @click:append-outer="sendMessage(message)" append-outer-icon="mdi-send" dense
      class="ml-10 mt-7 bottom" placeholder="メッセージを送信する" type="text" no-details outlined />
  </div>
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  import Appearance from '../../components/Appearance';
  import Avatar from '../page/TheAvatar';
  import moment from 'moment';

  const ROOM_URL = '/api/v1/rooms'

  export default {
    name: "Room",
    components: {
      'appearance': Appearance,
      'avatar': Avatar,
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
      this.checkSignedIn()
    },
    watch: {
      '$route.query': {
        immediate: true,
        handler() {
          this.createCable()
          this.getMessage()
        }
      }
    },
    channels: {
      RoomChannel: {
        connected() {},
        rejected() {},
        received(data) {
          if ((data["token"] === this.room_token) && (data["token"] === `${this.$route.params.token}`)) {
            this.messages.push(data)
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
        this.avatar = response.data.data.attributes.avatar_info
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      sendMessage(message) {
        if(message) {
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
      // checkAvatar(user_id) {
      //   for (let i = 0; this.avatar.length > i; i++) {
      //     if (this.avatar[i]["user_id"] === user_id) {
      //       return this.avatar[i].avatar
      //     }
      //   }
      // },
      postedTime(message){
        moment.locale('ja')
        return moment(message).format("MMMDo(dd) h:mm")
      }
    }
  }
</script>

<style>
  .bottom {
    width: 90%;
    text-align: center;
  }
</style>