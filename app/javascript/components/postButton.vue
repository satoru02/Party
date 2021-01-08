<template>
    <router-link to="/posts/new">
      <v-btn class="mx-1" fab dark small color="indigo">
        <v-icon dark>
          mdi-plus
        </v-icon>
      </v-btn>
    </router-link>
</template>

<script>
  export default {
    name: 'post'
  }
</script>