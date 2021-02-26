<template>
  <v-bottom-navigation v-if="$vuetify.breakpoint.width < 600" :background-color="color" active-class="#ffffff" fixed>
    <v-btn>
      <v-icon color="#ffffff">mdi-home-outline</v-icon>
    </v-btn>
    <v-btn>
      <v-icon color="#ffffff">mdi-heart-outline</v-icon>
    </v-btn>
    <v-btn>
      <v-icon color="#ffffff">mdi-plus</v-icon>
    </v-btn>
    <v-btn>
      <v-icon color="#ffffff">mdi-chat-outline</v-icon>
    </v-btn>
    <v-btn>
      <v-icon color="#ffffff">mdi-bell-outline</v-icon>
    </v-btn>
  </v-bottom-navigation>
</template>

<script>
  export default {
    name: "TheBottomNavigation",
    data(){
      return{
        color: "#242629"
      }
    }
  }
</script>