<template>
  <v-col class="pa-2 mt-14 ml-n16 ">
    <v-icon>mdi-wifi</v-icon>
  </v-col>
</template>

<script>
import consumer from '../../channels/consumer.js';

const SUBSCRIBER = consumer.subscriptions.create({
  channel: "NotificationsChannel",
})

SUBSCRIBER.received = function(data) {
  console.log(data)
  // console.log(`${this.$store.state.currentUser.id}`)
}

export default {
  name: 'Notifications'
}
</script>