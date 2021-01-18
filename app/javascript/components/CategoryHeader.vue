<template>
  <div class="category">
    <v-container class="mt-16 ml-16">
      <v-row no-gutters>
        <h2 class="mb-5 ml-8 mt-n3">Category</h2>
        <v-col v-for="(category, index) in categories" :key="index" class="mb-4 ml-8" cols="12" sm="16">
          <router-link :to="{name: 'Category', params: {slug: `${ category.attributes.slug }`}}">
            <div class="category_item" style="color:#d3d3d3; font-size: 15px;">{{ category.attributes.name }}</div>
          </router-link>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
  import {
    simpleAxios,
    secureAxios
  } from '../backend/axios.js'

  const CATEGORY_URL = `/api/v1/categories`

  export default {
    name: "categoryHeader",
    data() {
      return {
        categories: []
      }
    },
    created() {
      this.getCategory()
    },
    methods: {
      getCategory() {
        simpleAxios.get(CATEGORY_URL)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.categories = response.data.data
      },
      Failed(error) {
        console.log(error)
        this.error = (error.response && error.response.data && error.response.data.error) || ""
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