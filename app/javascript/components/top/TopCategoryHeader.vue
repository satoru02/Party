<template>
    <v-container class="ml-16">
      <v-row no-gutters>
        <v-col md=12 lg=12 xl=12 v-for="(category, index) in categories" :key="index" class="mb-5 ml-8">
          <v-row no-gutters>
            <v-col md=2 lg=2 xl=2>
              <v-btn style="background-color:#212529; width:30px; height:30px;" icon>
                 <v-icon color="#8b949e" small>
                   {{ applyIcon(category) }}
                 </v-icon>
              </v-btn>
            </v-col>
            <v-col md=8 lg=10 xl=10 align="start" class="mt-1">
              <div @click="moveCategory(category)" class="text">{{ category.attributes.name }}</div>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios.js'
  const CATEGORY_URL = `/api/v1/categories`

  export default {
    name: "TopCategoryHeader",
    data() {
      return {
        categories: [],
        movieIcon: `mdi-movie`,
        tvIcon: `mdi-television`,
        zoomIcon: `mdi-video`,
        offlineIcon: `mdi-account-multiple-outline`,
        comedyIcon: `mdi-emoticon`,
        freeIcon: `mdi-human-handsup`
      }
    },
    created() {
      this.getCategory()
    },
    methods: {
      getCategory() {
        secureAxios.get(CATEGORY_URL)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.categories = response.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      moveCategory(category){
        this.$router.push({
          name: 'Category',
          params:{
            slug: category.attributes.slug
          }
        })
      },
      applyIcon(category){
        if(category.attributes.name === "Movie"){
          return this.movieIcon
        } else if(category.attributes.name === "TV"){
          return this.tvIcon
        } else if(category.attributes.name === "Zoom chat"){
          return this.zoomIcon
        } else if(category.attributes.name === "Offline"){
          return this.offlineIcon
        } else if(category.attributes.name === "Comedy"){
          return this.comedyIcon
        } else if(category.attributes.name === "Free"){
          return this.freeIcon
        }
      }
    }
  }
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

  .text {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    font-size: 0.9rem;
    color: #8b949e;
  }

  .text:hover {
    color: #edf6f9;
    cursor: pointer;
  }
</style>