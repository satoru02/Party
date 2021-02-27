<template>
  <div class="card-tile" justify="center" align="center">
    <v-sheet height="550" class="rounded-s sheet" width="650">
      <v-row>
        <v-col cols="12" md="12" class="mt-12">
          <h1 class="title" style="color:black;"><span class="underline">New Message</span></h1>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" md="2">
          <base-avatar />
        </v-col>
        <v-col cols="12" md="3" class="mt-4 ml-n15">
          <router-link :to="{name: 'Posts', params: { id: message.user_id }}">
            <h3 style="color:black;">{{ message.user_info.name }}</h3>
          </router-link>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" md="1" />
        <v-col cols="12" md="10" class="mt-5">
          <p style="color:black; font-size: 1.0rem;">あなたが主催するイベントのParty
            room「{{ message.room_info.name }}」に、メッセージが届きました。早速返信してみましょう！</p>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=12 class="mt-16">
          <router-link :to="{ name: 'Room', params: { token: message.room_info.resource_token }}">
            <v-icon color="#6c757d">mdi-arrow-right</v-icon>
          </router-link>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=9 />
        <v-col cols=12 md=3 class="mt-16">
          <h3 style="color:#6c757d; font-size: 0.5rem">{{ catchedTime(message.created_at) }}</h3>
        </v-col>
      </v-row>
    </v-sheet>
  </div>
</template>

<script>
  import BaseAvatar from '../base/BaseAvatar';
  import moment from 'moment';

  export default {
    name: 'NotificationMessage',
    components: {
      'base-avatar': BaseAvatar
    },
    props: {
      message: {
        type: Object,
        required: true,
      },
    },
    created(){
      document.title = "Entry - Plaza"
    },
    methods: {
      catchedTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      }
    }
  }
</script>

<style scoped>
  .underline {
    background-image: linear-gradient(120deg, #84fab0 0%, #8fd3f4 100%);
    background-repeat: no-repeat;
    background-size: 100% 0.2em;
    background-position: 0 88%;
  }

  .sheet {
    background-image: linear-gradient(120deg, #84fab0 0%, #8fd3f4 100%);
    background-repeat: no-repeat;
    background-size: 100% 100em;
    background-position: 0 88%;
  }

  .title span {
    font-size: 30px;
  }
</style>