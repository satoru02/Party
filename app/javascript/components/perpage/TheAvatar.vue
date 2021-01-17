<template>
  <v-list-item-avatar color="white darken-3" :size="size" :avatar_url="avatar_url">
    <v-img class="elevation-1" alt="" :src="avatar_url">
    </v-img>
  </v-list-item-avatar>
</template>

<script>

export default {
  name: 'avatar',
  props:{
    avatar_url: String,
    size: Number
  }
}
</script>