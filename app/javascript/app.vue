<template>
  <div id="app">
    <v-app style="background-color:#161a1d">
      <top-header></top-header>
      <v-main>
        <router-view></router-view>
      </v-main>
      <!-- <info-footer></info-footer> -->
    </v-app>
  </div>
</template>

<script>
  import Vue from 'vue';
  import VueRouter from 'vue-router';
  import VuePaginate from 'vue-paginate';
  import Vuex from 'vuex';
  import createPersistedState from 'vuex-persistedstate';
  import InfiniteLoading from 'vue-infinite-loading';
  import Avatar from './components/page/TheAvatar.vue';
  import Header from './components/page/TheHeader.vue';
  import Login from './Login.vue';
  import Signup from './Signup.vue';
  import Activation from './Activation.vue';
  import UsersList from './components/admin/users/List.vue';
  import UserPostsList from './components/admin/users/posts/List.vue';
  import ForgotPassword from './components/ForgotPassword.vue';
  import ResetPassword from './components/ResetPassword.vue';
  import UserEdit from './components/Edit.vue';
  import Settings from './components/user/Settings';
  import User from './components/user/User';
  import PostEdit from './components/PostEdit.vue';
  import Room from './components/Room.vue';
  import Rooms from './components/Rooms.vue';
  import Notification from './components/Notification';
  import Notifications from './components/Notifications';
  import ActionCableVue from 'actioncable-vue';
  import Post from './components/post';
  import InfoFooter from './components/page/TheFooter';
  import Check from './Check';
  import InitialSettings from './components/user/InitialSettings';
  import Top from './components/Top';
  import FilterCard from './components/FilterCard';
  import UserFilterCard from './components/user/UserFilterCard';
  import RoomTop from './components/RoomTop';
  import Logout from './Logout';
  import '@mdi/font/css/materialdesignicons.css';

  const actionCableVueOptions = {
    debug: true,
    debugLevel: 'error',
    connectionUrl: 'ws://localhost:5000/cable',
    connectImmediately: true
  };

  Vue.use(ActionCableVue, actionCableVueOptions)
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
        return state.currentUser && state.currentUser.data.attributes.id
      }
    },
    mutations: {
      setCurrentUser(state, {
        currentUser,
        csrf,
        token
      }) {
        state.currentUser = currentUser
        state.signedIn = true
        state.csrf = csrf
        state.token = token
      },
      unsetCurrentUser(state) {
        state.currentUser = {}
        state.signedIn = false
        state.csrf = null
        state.token = null
      },
      refresh(state, csrf) {
        state.signedIn = true
        state.csrf = csrf
      }
    },
    plugins: [createPersistedState()]
  })

  const router = new VueRouter({
    mode: 'history',
    routes: [{
        path: "/",
        component: Top,
        children: [{
            path: '',
            name: "Top",
            component: FilterCard
          },
          {
            path: '/results/:query',
            name: "TopFilter",
            component: FilterCard
          },
          {
            path: "/category/:slug",
            name: "Category",
            component: FilterCard
          },
          {
            path: "/search/:query",
            name: "Search",
            component: FilterCard
          },
          {
            path: "/tag/:name",
            name: "Tag",
            component: FilterCard
          },
        ]
      },
      {
        path: "/users/:id",
        component: User,
        children: [
          {
            path: '',
            name: "MyEvents",
            component: UserFilterCard,
            props: (route) => ({
              query: route.query.status
            })
          },
          {
            path: "joined-events",
            name: "JoinedEvents",
            component: UserFilterCard,
            props: (route) => ({
              query: route.query.status
            })
          },
          {
            path: "settings",
            name: "Settings",
            component: Settings
          }
        ]
      },
      {
        path: "/rooms",
        component: Rooms,
        children: [
        {
          path:'',
          name: "Rooms",
          component: RoomTop
        },
        {
          path: "/room/:name/:token",
          name: "Room",
          component: Room,
        },
      ]
      },
      {
        path: "/login",
        name: "login",
        component: Login
      },
      {
        path: "/logout",
        name: "logout",
        component: Logout
      },
      {
        path: "/signup",
        name: "signup",
        component: Signup
      },
      {
        path: "/verify-email/:email",
        name: "check",
        component: Check
      },
      {
        path: "/account_activations/:token",
        name: "AccountActivations",
        component: Activation
      },
      {
        path: "/initial-settings",
        name: "InitialSettings",
        component: InitialSettings
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
      },
      {
        path: "/upload",
        name: "Post",
        component: Post
      },
      {
        path: "/events/edit/:id",
        name: "PostEdit",
        component: PostEdit
      },
      {
        path: "/notifications",
        name: "Notifications",
        component: Notifications
      },
      {
        path: "/notification/:id",
        name: "Notification",
        component: Notification
      },
    ]
  })

  export default {
    router,
    store,
    components: {
      'avatar': Avatar,
      'top-header': Header,
      'info-footer': InfoFooter
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