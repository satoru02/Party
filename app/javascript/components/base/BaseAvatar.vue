<template>
  <v-avatar
    color="darken-3"
    :size="size"
    >
    <v-img
      class="elevation-1"
      :size="size"
      :src="avatar_url" />
  </v-avatar>
</template>

<script>

export default {
  name: 'BaseAvatar',
  props:{
    avatar_url: {
      type: String,
      // #local disk
      default: "https://cdn.vuetifyjs.com/images/john.jpg"
    },
    size: {
      type: Number,
      default: 30
    }
  }
}
</script>