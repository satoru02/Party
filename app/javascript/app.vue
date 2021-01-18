<template>
  <div id="app">
    <v-app style="background-color:#161a1d">
      <top-header></top-header>
      <v-spacer></v-spacer>
      <v-main>
        <router-view></router-view>
      </v-main>
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
  import Avatar from './components/perpage/TheAvatar.vue';
  import Header from './components/perpage/TheHeader.vue';
  import Home from './home.vue';
  import Login from './Login.vue';
  import Signup from './Signup.vue';
  import Activation from './Activation.vue';
  import UsersList from './components/admin/users/List.vue';
  import UserPostsList from './components/admin/users/posts/List.vue';
  import ForgotPassword from './components/ForgotPassword.vue';
  import ResetPassword from './components/ResetPassword.vue';
  import UserEdit from './components/Edit.vue';
  import Users from './components/user/users.vue';
  import User from './components/user/user.vue';
  import Setting from './components/user/setting.vue';
  import PostEdit from './components/PostEdit.vue';
  import Category from './components/Category.vue';
  import Search from './components/Search.vue';
  import Room from './components/Room.vue';
  import Rooms from './components/Rooms.vue';
  import Notification from './components/Notification';
  import Notifications from './components/Notifications';
  import ActionCableVue from 'actioncable-vue';
  import Post from './components/post';
  import InfoFooter from './components/perpage/TheFooter';
  import Tag from './components/Tag';
  import Chat from './components/chat';
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
        csrf
      }) {
        state.currentUser = currentUser
        state.signedIn = true
        state.csrf = csrf
      },
      unsetCurrentUser(state) {
        state.currentUser = {}
        state.signedIn = false
        state.csrf = null
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
      },
      {
        path: "/account_activations/:token",
        name: "AccountActivations",
        component: Activation
      },
      {
        path: "/users",
        name: "Users",
        component: Users
      },
      {
        path: "/users/:id",
        name: "User",
        component: User
      },
      {
        path: "/setting",
        name: "Setting",
        component: Setting
      },
      {
        path: "/posts/new",
        name: "Post",
        component: Post
      },
      {
        path: "/posts/edit/:id",
        name: "PostEdit",
        component: PostEdit
      },
      {
        path: "/category/:slug",
        name: "Category",
        component: Category
      },
      {
        path: "/search/:query",
        name: "Search",
        component: Search
      },
      // {
      //   path: "/chat",
      //   name: "Chat",
      //   component: Chat,
      //   children: [{
      //     path: "rooms",
      //     name: "Rooms",
      //     component: Rooms,
      //     children: [{
      //         path: ":token",
      //         name: "Room",
      //         component: Room
      //       },
      //     ]
      //   },
      //   ]
      // },
      // {
      //   path: "/rooms",
      //   name: "Rooms",
      //   component: Rooms
      // },
      // {
      //   path: "/room/:token",
      //   name: "Room",
      //   component: Room
      // },
      {
        path: "/rooms",
        name: "Rooms",
        component: Rooms,
        children: [{
          path: ":token",
          name: "Room",
          component: Room
        },
        ]
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
      {
        path: "/tag/:id",
        name: "Tag",
        component: Tag
      }
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