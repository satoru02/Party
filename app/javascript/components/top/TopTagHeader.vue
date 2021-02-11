<template>
  <v-responsive class="overflow-y-auto flex-grow-1 flex-shrink-0" style="max-width: 80%;" height="400">
    <div class="tag">
      <v-container class="ml-16">
        <v-row no-gutters>
          <h2 class="mb-5 ml-8 mt-n3">ピックアップ</h2>
          <v-col v-for="(tag, index) in tags" :key="index" class="ml-8" cols="12" sm="16">
            <v-hover>
              <router-link :to="{name: 'Tag', params: {name: `${ tag.attributes.name }`}}">
                <p class="tag_item" style="color:#d3d3d3; font-size: 15px;">#{{ tag.attributes.name }}</p>
              </router-link>
            </v-hover>
          </v-col>
        </v-row>
      </v-container>
    </div>
  </v-responsive>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const TAG_URL = `/api/v1/tags`

  export default {
    name: "TopTagHeader",
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
        secureAxios.get(TAG_URL)
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

  .tag_item:hover {
    color: #000000;
  }
</style>