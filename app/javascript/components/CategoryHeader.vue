<template>
  <div class="category">
    <v-container class="mt-16 ml-10">
      <v-row no-gutters>
      <h2 class="mb-5 ml-8 mt-n3">Category</h2>
        <v-col v-for="(n,index) in categories" :key="index" class="mb-4 ml-8" cols="12" sm="16">
          <div class="category_item" style="color:#d3d3d3; font-size: 15px;">📽 {{ n }}</div>
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

<style>
@import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

  .category_item {
    font-family: 'Roboto', sans-serif;
  }
</style>