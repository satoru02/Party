<template>
  <v-app-bar app color="black">
    <v-container>
      <v-row class="d-flex justify-space-around mb-6">
        <v-col class="pa-2 mt-13">
          <h3 style="color:white">LAPLACE</h3>
        </v-col>
        <v-spacer></v-spacer>
        <v-col class="pa-2 mt-10">
          <v-text-field></v-text-field>
        </v-col>
        <v-spacer></v-spacer>
        <v-col class="pa-2 mt-14 ml-n16 ">
          <v-icon>mdi-menu</v-icon>
        </v-col>
        <v-col class="pa-2 mt-14 ml-n16 ">
          <v-icon>mdi-wifi</v-icon>
        </v-col>
        <v-col class="pa-2 mt-10">
          <avatar></avatar>
        </v-col>
      </v-row>
    </v-container>
  </v-app-bar>
</template>

<script>
  import Avatar from './TheAvatar.vue';

  export default {
    name: 'top-header',
    components: {
      'avatar': Avatar,
    }
  }
</script>

<style>
</style>