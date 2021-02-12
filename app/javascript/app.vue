<template>
  <div id="app">
    <v-app style="background-color:#0e0e10">
      <top-header></top-header>
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
  import ActionCableVue from 'actioncable-vue';
  import '@mdi/font/css/materialdesignicons.css';

  import Header from './components/page/TheHeader.vue';

  import UsersList from './components/admin/users/List.vue';
  import UserPostsList from './components/admin/users/posts/List.vue';

  import Login from './components/authorization/Login';
  import Signup from './components/authorization/Signup';
  import AccountActivation from './components/authorization/AccountActivation';
  import ForgotPassword from './components/authorization/ForgotPassword';
  import ResetPassword from './components/authorization/ResetPassword';
  import Logout from './components/authorization/Logout';
  import MailCheck from './components/authorization/MailCheck';

  import UserEdit from './components/admin/users/Edit.vue';
  import UserSettings from './components/user/UserSettings';
  import UserTop from './components/user/UserTop';
  import UserInitialSettings from './components/user/UserInitialSettings';
  import UserCardFilter from './components/user/UserCardFilter';
  import UserFollowing from './components/user/UserFollowing';
  import UserFollowers from './components/user/UserFollowers';

  import Room from './components/room/Room.vue';
  import Rooms from './components/room/Rooms.vue';
  import RoomTop from './components/room/RoomTop';

  import Notification from './components/notification/Notification';
  import Notifications from './components/notification/Notifications';

  import Post from './components/upload/Post';
  import PostEdit from './components/upload/PostEdit.vue';

  import Top from './components/top/TopPage';
  import TopCardFilter from './components/top/TopCardFilter';

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
      },
      follow(state, user_id) {
        state.currentUser.data.attributes.following.push(user_id)
      },
      unfollow(state, user_id) {
        state.currentUser.data.attributes.following = state.currentUser.data.attributes.following.filter(
          following => following != user_id
        )
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
            component: TopCardFilter
          },
          {
            path: '/results/:query',
            name: "TopFilter",
            component: TopCardFilter
          },
          {
            path: "/category/:slug",
            name: "Category",
            component: TopCardFilter
          },
          {
            path: "/search/:query",
            name: "Search",
            component: TopCardFilter
          },
          {
            path: "/tag/:name",
            name: "Tag",
            component: TopCardFilter
          },
        ]
      },
      {
        path: "/users/:id",
        component: UserTop,
        children: [
          {
            path: '',
            name: "MyEvents",
            component: UserCardFilter,
            props: (route) => ({
              query: route.query.status
            })
          },
          {
            path: "joined-events",
            name: "JoinedEvents",
            component: UserCardFilter,
            props: (route) => ({
              query: route.query.status
            })
          },
          {
            path: "following",
            name: "UserFollowing",
            component: UserFollowing,
            props: (route) => ({
              query: route.query.status
            })
          },
          {
            path: "followers",
            name: "UserFollowers",
            component: UserFollowers,
            props: (route) => ({
              query: route.query.status
            })
          },
          {
            path: "settings",
            name: "Settings",
            component: UserSettings
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
        component: MailCheck
      },
      {
        path: "/account_activations/:token",
        name: "AccountActivations",
        component: AccountActivation
      },
      {
        path: "/initial-settings",
        name: "InitialSettings",
        component: UserInitialSettings
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
      'top-header': Header
    }
  }
</script>

<style scoped>
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