<template>
  <div class="category">
    <v-container class="mt-16 ml-15" >
      <v-row no-gutters>
        <v-col v-for="(n,index) in categories" :key="index" class="mb-7 ml-8" cols="12" sm="16">
          <!-- <v-btn style="background-color:#2d00f7">{{ n }}</v-btn> -->
          <h3>{{ n }}</h3>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "categoryHeader",
  data() {
    return {
      categories: [
        "Movie",
        "Streaming",
        "Comedy",
        "Zoom",
        "Drama",
        "TV",
        "Chat",
        "Videos",
        "Podcasts"
      ]
    }
  }
}
</script>