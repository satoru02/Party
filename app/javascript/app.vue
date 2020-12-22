<template>
  <div id="app">
    <v-app style="background-color:#0c0e17">
      <top-header></top-header>
      <v-spacer></v-spacer>
      <v-main>
        <div class="center-content">
        </div>
        <router-view></router-view>
      </v-main>
    </v-app>
  </div>
</template>

<script>
  import Vue from 'vue';
  import Home from 'home.vue';
  import VueRouter from 'vue-router';
  import VuePaginate from 'vue-paginate';
  import Avatar from './components/perpage/TheAvatar.vue';
  import Header from './components/perpage/TheHeader.vue';
  import InfiniteLoading from 'vue-infinite-loading';
  import Login from './Login.vue';
  import Signup from './Signup.vue';
  import '@mdi/font/css/materialdesignicons.css';

  Vue.use(VuePaginate)
  Vue.use(VueRouter)
  Vue.use(InfiniteLoading, {
    slots: {
      noMore: "",
      error: {
        render: h => h('div'),
      },
    }
  })

  const router = new VueRouter({
    mode: 'history',
    routes: [
      {
        path: "/",
        name: "home",
        component: Home
      },
      {
        path: "/login",
        name: "login",
        component: Login
      },
      {
        path: "/signup",
        name: "signup",
        component: Signup
      }
    ]
  })

  export default {
    router,
    components: {
      'avatar': Avatar,
      'top-header': Header,
    }
  }
</script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat&family=Open+Sans:wght@400;700&display=swap');

  h3 {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
  }

  .logo {
    margin-left: 1240px;
  }
</style>