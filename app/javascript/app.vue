<template>
  <div id="app">
    <v-app>
      <v-app-bar app>
        <h2>Broadcast</h2>
        <v-spacer></v-spacer>
      </v-app-bar>
      <v-main>
        <div class="center-content">
        </div>
        <router-view></router-view>
      </v-main>
      <v-footer padless>
        <v-col class="text-center" cols="12">2021</v-col>
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