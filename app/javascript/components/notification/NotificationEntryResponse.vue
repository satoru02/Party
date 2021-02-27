<template>
  <div justify="center" align="center">
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=10 lg=6 xl=6>
        <v-sheet elevation=5 style="height:auto; width:auto;" class="rounded-lg sheet">
          <v-row>
            <v-col cols=12 sm=12 md=12 lg=12 xl=12 class="mt-12">
              <h1 class="title" style="color:black;"><span class="underline">Entry Notification</span></h1>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-15">
              <base-avatar />
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-4 ml-n7">
              <router-link :to="{name: 'Posts', params: { id: entry_response.user_info.id }}">
                <h3 style="color:black;">{{ entry_response.user_info.name }}</h3>
              </router-link>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10 class="mt-5">
              <p v-if="entry_response.entry_response_info.answer === false" style="color:black; font-size: 1.0rem;">
                ごめんなさい。エントリーしていたイベント「{{ entry_response.room_info.name }}」への参加は、キャンセルになりました。
              </p>
              <p v-if="entry_response.entry_response_info.answer === true" style="color:black; font-size: 1.0rem;">
                おめでとうございます！{{ entry_response.user_info.name }}さんから、「{{ entry_response.room_info.name }}」へ招待されています！
              </p>
              <v-row class="mt-10">
                <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
              </v-row>
              <p v-if="entry_response.entry_response_info.answer === false" style="color:black; font-size: 1.0rem;">
                [理由]今回のイベントは定員に達したため
              </p>
              <p v-if="entry_response.entry_response_info.answer === true" style="color:black; font-size: 1.0rem;">
                早速Party Roomに参加しましょう！
              </p>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-row>
            <v-col v-if="entry_response.entry_response_info.answer === true" cols=12 md=12 class="mt-16">
              <router-link :to="{ name: 'Room', params: { token: entry_response.room_info.resource_token }}">
                <v-icon color="#6c757d">mdi-arrow-right</v-icon>
              </router-link>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=9 sm=9 md=9 lg=9 xl=9 />
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-16">
              <h3 style="color:#6c757d; font-size: 0.5rem">{{ catchedTime(entry_response.created_at) }}</h3>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
    </v-row>
  </div>
</template>

<script>
  import BaseAvatar from '../base/BaseAvatar';
  import moment from 'moment';

  export default {
    name: 'NotificationEntryReponse',
    components: {
      'base-avatar': BaseAvatar
    },
    props: {
      entry_response: {
        type: Object,
        required: true
      }
    },
    created(){
      document.title = "Response - title"
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
    background-image: linear-gradient(120deg, #fa84f0 0%, #8ff4e7 100%);
    background-repeat: no-repeat;
    background-size: 100% 0.2em;
    background-position: 0 88%;
  }

  .sheet {
    background-image: linear-gradient(120deg, #fa84f0 0%, #8ff4e7 100%);
    background-repeat: no-repeat;
    background-size: 100% 100em;
    background-position: 0 88%;
  }

  .title span {
    font-size: 30px;
  }
</style>