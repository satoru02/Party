<template>
  <v-sheet class="rounded-lg" width=340  color="#11151c" elevation=4
    style="height:auto; min-height: 420px; max-width: 100%; max-height:1000px;">
    <v-row no-gutters>
      <v-col lg=1 />
      <v-col lg=10 align="start" class="mt-6">
        <h3 class="text">Pickup Events</h3>
      </v-col>
      <v-col lg=1 />
    </v-row>
    <v-row>
      <v-col lg=12 />
    </v-row>

    <v-row v-for="(n,index) in 10" :key="index" class="mt-n2">
      <v-col lg=1 />
      <v-col lg=7>
        <h3 class="events">ドキュメン鑑賞会</h3>
      </v-col>
      <v-col lg=1 class="mt-1">
        <v-btn width="10" height="14" color="pink">
          new
        </v-btn>
      </v-col>
    </v-row>
  </v-sheet>
</template>

<script>
  export default {
    name: 'TopPopularContents',
  }
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

  .text {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    color: #ffffff;
  }

  .events {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    /* font-weight: bold; */
    color: #d6d6d6;
    font-size: 0.8rem;
  }

  .v-btn:not(.v-btn--round).v-size--default {
  min-width: 0;
}
</style>