<template>
  <div id="app">
    <v-app style="background-color:#0f0e17">
      <v-app-bar app color="black">
        <h3 style="color:white">Broadcast</h3>
        <v-spacer></v-spacer>
      </v-app-bar>
      <v-spacer></v-spacer>
      <v-main>
        <div class="center-content">
        </div>
        <router-view></router-view>
      </v-main>
      <v-footer padless dark height=270 color="black">
        <v-col class="text-center" cols="12"></v-col>
      </v-footer>
    </v-app>
  </div>
</template>

<script>
  import Vue from 'vue';
  import Home from 'home.vue';
  import VueRouter from 'vue-router';
  import VuePaginate from 'vue-paginate';

  Vue.use(VueRouter)
  Vue.use(VuePaginate)

  const router = new VueRouter({
    mode: 'history',
    routes: [{
      path: "/",
      name: "home",
      component: Home
    }]
  })

  export default {
    router,
  }
</script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat&family=Open+Sans:wght@400;700&display=swap');

  h3 {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
  }
</style>
