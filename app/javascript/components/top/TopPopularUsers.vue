<template>
  <v-sheet class="rounded-lg" width=320 height=400 color="#11151c" elevation=14
    style="height:auto; min-height: 220px; max-height:1000px; width:auto;">
    <v-row no-gutters>
      <v-col lg=1 />
      <v-col lg=10 align="start" class="mt-6">
        <h3 class="text">Popular Users</h3>
      </v-col>
      <v-col lg=1 />
    </v-row>
    <v-row>
      <v-col lg=1 xl=1 />
      <v-col md=2 lg=3 xl=3 align="end">
        <base-avatar :size="40" />
        <v-row no-gutters>
          <v-col lg=12 xl=12 class="hidden-md-only" align="center">
            <h3 class="username">John</h3>
          </v-col>
        </v-row>
      </v-col>
      <v-col md=2 lg=3 xl=3 align="end" class="ml-3 mr-3">
        <base-avatar :size="40" />
        <v-row no-gutters>
          <v-col lg=12 xl=12 class="hidden-md-only" align="center">
            <h3 class="username">Smith</h3>
          </v-col>
        </v-row>
      </v-col>
      <v-col md=2 lg=3 xl=3 align="end">
        <base-avatar :size="40" />
        <v-row no-gutters>
          <v-col lg=12 xl=12 class="hidden-md-only" align="center">
            <h3 class="username">Sugiwaka</h3>
          </v-col>
        </v-row>
      </v-col>
      <v-col lg=1 xl=1 />
    </v-row>
    <v-row class="mt-n10">
     <v-col lg=1 xl=1 />
      <v-col md=2 lg=3 xl=3 align="end">
        <base-avatar :size="40" />
        <v-row no-gutters>
          <v-col lg=12 xl=12 class="hidden-md-only" align="center">
            <h3 class="username">Alice</h3>
          </v-col>
        </v-row>
      </v-col>
      <v-col md=2 lg=3 xl=3 align="end" class="ml-3 mr-3">
        <base-avatar :size="40" />
        <v-row no-gutters>
          <v-col lg=12 xl=12 class="hidden-md-only" align="center">
            <h3 class="username">Ted</h3>
          </v-col>
        </v-row>
      </v-col>
      <v-col md=2 lg=3 xl=3 align="end">
        <base-avatar :size="40" />
        <v-row no-gutters>
          <v-col lg=12 xl=12 class="hidden-md-only" align="center">
            <h3 class="username">Lowly</h3>
          </v-col>
        </v-row>
      </v-col>
      <v-col lg=1 xl=1 />
    </v-row>
  </v-sheet>
</template>

<script>
  import BaseAvatar from '../base/BaseAvatar';

  export default {
    name: 'TopPopularUsers',
    components: {
      'base-avatar': BaseAvatar
    }
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

  .username {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    font-size: 0.6rem;
    color: #8b949e;
  }
</style>