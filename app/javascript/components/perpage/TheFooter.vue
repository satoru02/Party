<template>
  <v-footer padless color="black" height="270">
    <v-row justify="center" no-gutters>
      <v-btn v-for="index in 6" :key="index" color="white" text rounded class="my-2">
        item
      </v-btn>
      <v-col class="black lighten-2 py-4 text-center white--text" cols="12">
        {{ new Date().getFullYear() }} -<strong>TITLE</strong>
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
</script>