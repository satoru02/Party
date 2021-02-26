<template>
  <v-avatar
    class="outlined"
    color="darken-3"
    :size="size"
    >
    <v-img
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

<style scoped>
.outlined {
  border: 1px solid #495057;
  border-radius: 50%;
}
</style>