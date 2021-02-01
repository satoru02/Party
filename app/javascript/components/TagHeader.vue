<template>
  <div class="tag">
    <v-container class="ml-16">
      <v-row no-gutters>
        <h2 class="mb-5 ml-8 mt-n3">ピックアップ</h2>
        <v-col v-for="(tag, index) in tags" :key="index" class="mb-4 ml-8" cols="12" sm="16">
          <router-link :to="{name: 'Tag', params: {name: `${ tag.attributes.name }`}}">
            <div class="tag_item" style="color:#d3d3d3; font-size: 15px;">#{{ tag.attributes.name }}</div>
          </router-link>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
  import { simpleAxios, secureAxios } from '../backend/axios.js'

  const TAG_URL = `/api/v1/tags`

  export default {
    name: "TagHeader",
    data() {
      return {
        tags: []
      }
    },
    created() {
      this.getTags()
    },
    methods: {
      getTags() {
        simpleAxios.get(TAG_URL)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.tags = response.data.data
      },
      Failed(error) {
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