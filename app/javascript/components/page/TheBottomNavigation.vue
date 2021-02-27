<template>
  <v-bottom-navigation v-if="$vuetify.breakpoint.width < 600" :background-color="color" active-class="#ffffff" fixed>
    <v-btn @click="moveTop()">
      <v-icon color="#ffffff">mdi-home-outline</v-icon>
    </v-btn>
    <v-btn @click="moveRooms()">
      <v-icon color="#ffffff">mdi-chat-outline</v-icon>
    </v-btn>
    <v-btn @click="movePost()">
      <v-icon color="#ffffff">mdi-plus</v-icon>
    </v-btn>
    <v-btn @click="moveNotifications()">
      <v-icon color="#ffffff">mdi-bell-outline</v-icon>
    </v-btn>
    <v-btn @click="moveAccount()">
      <v-icon color="#ffffff">mdi-account-outline</v-icon>
    </v-btn>
  </v-bottom-navigation>
</template>

<script>
  export default {
    name: "TheBottomNavigation",
    data(){
      return{
        color: "#222627"
      }
    },
    methods: {
      moveTop(){
        this.$router.push({name: "Top"})
      },
      movePost(){
        this.$router.push({name: "Post"})
      },
      moveRooms(){
        this.$router.push({name: "Rooms"})
      },
      moveNotifications(){
        this.$router.push({name: "Notifications"})
      },
      moveAccount(){
        this.$router.push({name: "MyEvents", params:{
          id: this.$store.state.currentUser.data.attributes.id
        }})
      }
    }
  }
</script>