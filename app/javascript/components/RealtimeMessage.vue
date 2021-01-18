<template>
  <v-card :realtime_messages="realtime_messages" color="#161a1d" flat class="fill-height">
    <v-card-text class="flex-grow-1 fill-height">
      <template v-for="(message, index) in realtime_messages">
        <div :key="index"
          :class="[ message.user_id === $store.state.currentUser.data.attributes.id ? 'd-flex flex-row-reverse': 'd-flex flex-row']">
          <avatar v-if="message.user_id !== $store.state.currentUser.data.attributes.id"></avatar>
          <v-menu offset-y>
            <template v-slot:activator="{ on }">
              <v-hover v-slot:default="{ hover }">
                <v-chip :color="message.user_id === $store.state.currentUser.data.attributes.id ? '#3a36ff': '#212530'"
                  :text-color="message.user_id === $store.state.currentUser.data.attributes.id ? '#ffffff': '#000000'"
                  style="height:auto; min-width:300px; max-width:500px; max-height:1000px; white-space: normal;"
                  class="pa-3 mb-4 mr-5" v-on="on">
                  <p class="ml-2 mt-4" style="font-size: 0.8rem;">{{ message.content }}</p>
                  <p v-if="message.classification === 'join'" class="ml-2 mt-4" style="font-size: 1rem;">
                    {{ message.user }}が、{{ message.time }}に参加しました。</p>
                  <v-icon v-if="hover" small></v-icon>
                </v-chip>
              </v-hover>
            </template>
          </v-menu>
        </div>
      </template>
    </v-card-text>
  </v-card>
</template>

<script>
  export default {
    name: "realtime-messages",
    props: {
      realtime_messages: Array
    }
  }
</script>