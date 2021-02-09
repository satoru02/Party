<template>
  <v-list-item-avatar
    color="white darken-3"
    :size="size"
    :avatar_url="avatar_url">
    <v-img
      class="elevation-1"
      alt=""
      :src="avatar_url" />
  </v-list-item-avatar>
</template>

<script>

export default {
  name: 'BaseAvatar',
  props:{
    avatar_url: {
      type: String,
    },
    size: {
      type: Number,
      default: 30
    }
  }
}
</script>