<template>
  <div>
    <tr id="post-content">
      <th>{{ post.title }}</th>
    </tr>
    <tr id="user-content">
      <th>{{ user.email }}</th>
    </tr>
    <!-- fix -->
    <div v-if="entry.activated === nil">
      <v-btn text color="primary" @click="authorizeEntry()">
        Authorize
      </v-btn>
      <v-btn text color="primary" @click="declineEntry()">
        Decline
      </v-btn>
    </div>
  </div>
</template>

<script>
  import { simpleAxios, secureAxios } from "../../backend/axios"
  const ENTRY_URL = `/api/v1/rooms_user`

  export default {
    name: "Entry",
    props: {
      entry: Object,
      post: Object,
      user: Object
    },
    methods: {
      authorizeEntry() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(ENTRY_URL, {
            answer: 'authorize',
            entry_id: this.entry.id,
            post_id: this.post.id,
            user_id: this.user.id
          })
          // モーダル表示
          this.$router.replace('/')
          .catch(error => this.Failed(error))
      },
      declineEntry() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.post(ENTRY_URL, {
            answer: 'decline',
            entry_id: this.entry.id,
            post_id: this.post.id,
            user_id: this.user.id
          })
          // モーダル表示
          this.$router.replace('/')
          .catch(error => this.Failed(error))
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>