<template>
  <div>
    <tr id="post-content">
      <th>{{ title }}</th>
    </tr>
    <tr id="user-content">
      <th>{{ email }}</th>
    </tr>
    <v-btn text color="primary" @click="authorizeEntry()">
      Authorize
    </v-btn>
    <v-btn text color="primary" @click="declineEntry()">
      Decline
    </v-btn>
  </div>
</template>

<script>
  import { simpleAxios, secureAxios } from "../../backend/axios"
  const ENTRY_URL = `/api/v1/rooms_user`

  export default {
    name: "Entry",
    props: {
      title: String,
      email: String,
      entry_id: Number,
      post_id: Number,
      user_id: Number
    },
    methods: {
      authorizeEntry() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(ENTRY_URL, {
            answer: 'authorize',
            entry_id: this.entry_id,
            post_id: this.post_id,
            user_id: this.user_id
          })
          .catch(error => this.Failed(error))
      },
      declineEntry() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(ENTRY_URL, {
            answer: 'decline',
            entry_id: this.entry_id,
            post_id: this.post_id,
            user_id: this.user_id
          })
          .catch(error => this.Failed(error))
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>