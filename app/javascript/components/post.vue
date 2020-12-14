<template>
  <div class="post-form">
    <v-btn class="mx-1" fab dark small color="indigo" @click="dialog = !dialog">
      <v-icon dark>
        mdi-plus
      </v-icon>
    </v-btn>

    <v-dialog v-model="dialog" max-width="600px" class="rounded">
      <v-card elevation="0">
        <v-card-text>
          <v-spacer></v-spacer>
          <v-text-field v-model="title" label="Title"></v-text-field>
          <v-text-field v-model="url" label="URL"></v-text-field>
          <v-text-field label="Category"></v-text-field>
          <v-text-field label="Platform"></v-text-field>
          <v-text-field label="一言"></v-text-field>
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text color="primary" @click="postUrl(title,url), dialog = !dialog">
            submit
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'post',
    data() {
      return {
        title: '',
        url: '',
        dialog: false,
      }
    },
    methods: {
      postUrl: function (title, url) {
        axios
          .post('/api/v1/posts', {
            title: title,
            url: url
          })
          .then(function (response) {})
      }
    }
  }
</script>