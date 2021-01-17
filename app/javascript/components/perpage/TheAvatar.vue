<template>
  <v-list-item-avatar color="white darken-3" size=27 :avatar_url="avatar_url">
    <v-img class="elevation-1" alt="" :src="avatar_url">
    </v-img>
  </v-list-item-avatar>
</template>

<script>
import URLloader from 'url-loader';
export default {
  name: 'avatar',
  props:{
    avatar_url: String,
  }
}
</script>