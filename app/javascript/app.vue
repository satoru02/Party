<template>
  <div id="app">
    <v-app dark>
      <v-main>
        <router-view></router-view>
      </v-main>
      <v-footer padless>
      <v-col class="text-center" cols="12">2020</v-col>
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

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>