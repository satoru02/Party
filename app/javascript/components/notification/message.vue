<template>
  <div justify="center" align="center">
    <v-sheet color="#eaf4f4" height="550" class="rounded-xl" width="650">
      <v-row>
        <v-col cols="12" md="12" class="mt-12">
          <h1 style="color:black;">New Message</h1>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" md="2">
          <avatar></avatar>
        </v-col>
        <v-col cols="12" md="2" class="mt-4 ml-n13">
          <router-link :to="{name: 'User', params: { id: message.user_id }}">
            <h3 style="color:black;">{{ message.user_info.name }}</h3>
          </router-link>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" md="1">
        </v-col>
        <v-col cols="12" md="10" class="mt-5">
          <p style="color:black; font-size: 1.0rem;">あなたが主催する{{message.room_info.name}}に、メッセージが届きました。早速返信してみましょう！</p>
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
        <v-col cols=12 md=9>
        </v-col>
        <v-col cols=12 md=3 class="mt-16">
          <h3 style="color:#6c757d; font-size: 0.5rem">{{ catchedTime(message.created_at) }}</h3>
        </v-col>
      </v-row>
    </v-sheet>
  </div>
</template>

<script>
  import Avatar from '../perpage/TheAvatar';
  import moment from 'moment';

  export default {
    name: 'Message',
    components: {
      'avatar': Avatar
    },
    props: {
      message: Object,
    },
    methods: {
      catchedTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      }
    }
  }
</script>