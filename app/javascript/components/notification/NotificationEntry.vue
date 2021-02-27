<template>
  <div justify="center" align="center">
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=10 lg=6 xl=6>
        <v-sheet elevation=13 style="height:auto; width:auto;" class="rounded-lg sheet">
          <v-row>
            <v-col cols=12 sm=12 md=12 lg=12 xl=12 class="mt-12">
              <h1 class="title" style="color:black;"><span class="underline">New Entry</span></h1>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-15">
              <base-avatar />
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-4 ml-n7" align-self="baseline">
              <router-link :to="{name: 'MyEvents', params: { id: user.id }}">
                <h3 style="color:black;">{{ user.username }}</h3>
              </router-link>
            </v-col>
            <v-col cols=5 sm=5 md=5 lg=5 xl=5 />
          </v-row>
          <v-row>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10 class="mt-5">
              <p style="color:black; font-size: 1.0rem;">
                あなたが主催するイベント「{{ post.title }}」に、{{ user.name }}さんからエントリーが届きました。このユーザーを招待しますか？</p>
            </v-col>
          </v-row>
          <v-row v-if="entry.activated === null && response_action === ''">
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-16" />
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-16">
              <v-btn rounded large text color="primary" @click="authorizeEntry(), authorizeDialog = true">
                <div style="font-size: 1.0rem;">招待する</div>
              </v-btn>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-16">
              <v-btn rounded large text color="primary" @click="declineEntry(), declineDialog = true">
                <div style="font-size: 1.0rem;">お断りする</div>
              </v-btn>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-16" />
          </v-row>
          <v-row>
            <v-col style="color:black; font-size: 1.0rem;"
              v-if="entry.activated == true || response_action === 'authorize'" cols=12 md=12 class="mt-16">
              <p class="output" style="color:black;">招待通知を送りました。</p>
            </v-col>
            <v-col style="color:black; font-size: 1.0rem;"
              v-if="entry.activated == false || response_action === 'decline'" cols=12 md=12 class="mt-16">
              <p class="output" style="color:black;">エントリーを今回は見送りました。</p>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=9 sm=9 md=9 lg=9 xl=9 />
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 class="mt-16">
              <h3 style="color:#6c757d; font-size: 0.5rem">{{ catchedTime(entry.created_at) }}</h3>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
    </v-row>
    <div class="dialog">
      <v-dialog light v-model="authorizeDialog" width="500">
        <v-card>
          <v-card-title>招待完了！</v-card-title>
          <v-card-text>{{user.name}}さんを、{{ post.title }}に招待しました！</v-card-text>
          <v-card-actions>
            <v-spacer />
            <v-btn color="primary" text @click="authorizeDialog = false">
              Close
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <v-dialog light v-model="declineDialog" width="500">
        <v-card>
          <v-card-title>お見送り完了！</v-card-title>
          <v-card-text>今回は{{ user.name }}さんの{{ post.title }}へのエントリーをお断りしました。</v-card-text>
          <v-card-actions>
            <v-spacer />
            <v-btn color="primary" text @click="declineDialog = false">
              Close
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
  </div>
</template>

<script>
  import {
    secureAxios
  } from "../../backend/axios"
  import BaseAvatar from '../base/BaseAvatar';
  import moment from 'moment';
  const ENTRY_URL = `/api/v1/rooms_user`

  export default {
    name: "NotificationEntry",
    components: {
      'base-avatar': BaseAvatar
    },
    data() {
      return {
        authorizeDialog: false,
        declineDialog: false,
        response_action: ''
      }
    },
    props: {
      entry: {
        type: Object,
        required: true,
      },
      post: {
        type: Object,
        required: true,
      },
      user: {
        type: Object,
        required: true
      }
    },
    created(){
      document.title = "Entry - title"
    },
    methods: {
      authorizeEntry() {
        secureAxios.post(ENTRY_URL, {
          answer: 'authorize',
          entry_id: this.entry.id,
          post_id: this.post.id,
          user_id: this.user.id
        })
        this.response_action = "authorize"
      },
      declineEntry() {
        secureAxios.post(ENTRY_URL, {
          answer: 'decline',
          entry_id: this.entry.id,
          post_id: this.post.id,
          user_id: this.user.id
        })
        this.response_action = "decline"
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      catchedTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      }
    }
  }
</script>

<style scoped>
  .underline {
    background-image: linear-gradient(120deg, #f8fa84 0%, #8fd3f4 100%);
    background-repeat: no-repeat;
    background-size: 100% 0.2em;
    background-position: 0 88%;
  }

  .sheet {
    background-image: linear-gradient(120deg, #f8fa84 0%, #8fd3f4 100%);
    background-repeat: no-repeat;
    background-size: 100% 100em;
    background-position: 0 88%;
  }

  .title span {
    font-size: 30px;
  }
</style>