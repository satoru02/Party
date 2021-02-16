<template>
  <v-responsive class="overflow-y-auto flex-grow-1 flex-shrink-0" style="max-width: 80%;" height="400">
      <v-container class="ml-16">
        <v-row no-gutters>
          <div class="mb-5 ml-8 mt-n3 tags">PICKUP TAGS</div>
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 v-for="(tag, index) in tags" :key="index" class="ml-8">
            <v-hover>
              <router-link :to="{name: 'Tag', params: {name: `${ tag.attributes.name }`}}">
                <!-- <v-btn rounded class="mb-2">
                  #{{ tag.attributes.name }}
                </v-btn> -->
                <p class="tag_item" style="font-size: 15px;">#{{ tag.attributes.name }}</p>
              </router-link>
            </v-hover>
          </v-col>
        </v-row>
      </v-container>
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

  .tags {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    font-size:0.9rem;
    font-weight: bold;
    color: #495057;
  }
  .tag_item {
    color: #929ba5;
  }

  .tag_item:hover {
    color: #edf6f9;
  }
</style>