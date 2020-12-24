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
  import Home from 'Home.vue';
  import VueRouter from 'vue-router';
  import VuePaginate from 'vue-paginate';
  import Vuex from 'vuex';
  import createPersistedState from 'vuex-persistedstate';
  import InfiniteLoading from 'vue-infinite-loading';
  import '@mdi/font/css/materialdesignicons.css';
  import Avatar from './components/perpage/TheAvatar.vue';
  import Header from './components/perpage/TheHeader.vue';
  import Login from './Login.vue';
  import Signup from './Signup.vue';
  import UsersList from './components/admin/users/List.vue';
  import UserPostsList from './components/admin/users/posts/List.vue';
  import ForgotPassword from './components/ForgotPassword.vue';
  import ResetPassword from './components/ResetPassword.vue';
  import UserEdit from './components/Edit.vue';

  Vue.use(VuePaginate)
  Vue.use(VueRouter)
  Vue.use(Vuex)
  Vue.use(InfiniteLoading, {
    slots: {
      noMore: "",
      error: {
        render: h => h('div'),
      },
    }
  })

  const store = new Vuex.Store({
    state: {
      currentUser: {},
      signedIn: false,
      csrf: null
    },
    getters: {
      isAdmin: state => {
        return state.currentUser.role == "admin"
      },
      isManager: state => {
        return state.currentUser.role == "manager"
      },
      currentUserId: state => {
        return state.currentUser && state.currentUser.id
      }
    },
    mutations: {
      setCurrentUser(state, {currentUser, csrf}) {
        state.currentUser = currentUser
        state.signedIn = true
        state.csrf = csrf
      },
      unsetCurrentUser(state) {
        state.currentUser = {}
        state.signedIn = false
        state.csrf = null
      },
      refresh (state, csrf) {
        state.signedIn = true
        state.csrf = csrf
      }
    },
    plugins: [createPersistedState()]
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
      },
      {
        path: "/admin/users",
        name: "UsersList",
        component: UsersList
      },
      {
        path: "/admin/users/:id/posts",
        name: "UserPostsList",
        component: UserPostsList
      },
      {
        path: "/forgot_password",
        name: "ForgotPassword",
        component: ForgotPassword
      },
      {
        path: "/password_resets/:token",
        name: "ResetPassword",
        component: ResetPassword
      },
      {
        path: "/admin/users/:id",
        name: "UserEdit",
        component: UserEdit
      }
    ]
  })

  export default {
    router,
    store,
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