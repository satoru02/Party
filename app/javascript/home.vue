<template>
  <div class="homes">
    <div>
      <v-container class="mt-10">
      </v-container>
    </div>
    <div>
      <v-container class="mt-10">
        <v-row no-gutters>
          <v-col class="mb-7 pr-6" v-for="post in posts" :key="post.id" :title="post.title" :url="post.url"
            :time="post.date" cols="12" sm="4">
            <v-card class="rounded-xl" elevation="10" color="#010101" max-width="400">
              <v-card-title>
                <p>{{ post.title }}</p>
              </v-card-title>
              <v-card-text>
                <a v-bind:href="post.url">{{ post.url }}</a>
              </v-card-text>
              <v-card-actions>
                <v-list-item class="grow">
                  <v-list-item-avatar color="grey darken-3" size=25>
                    <v-img class="elevation-1" alt=""
                      src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light">
                    </v-img>
                  </v-list-item-avatar>
                  <v-list-item-content>
                    <v-list-item-subtitle>John Smith</v-list-item-subtitle>
                  </v-list-item-content>
                  <v-row align="center" justify="end">
                    <span class="subheading mr-2" style="color:white">{{ post.date }}</span>
                  </v-row>
                </v-list-item>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </div>
    <!-- <post></post> -->
  </div>
</template>

<script>
  import axios from 'axios';
  import post from './components/Thepost.vue';

  export default {
    name: 'home',
    components: {
      'post': post
    },
    props: {
      title: String,
      url: String,
      time: String,
    },
    data() {
      return {
        posts: [],
      }
    },
    mounted() {
      axios.get('api/v1/posts')
        .then(response => {
          this.posts = response.data
        })
    }
  }
</script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat&family=Open+Sans:wght@400;700&display=swap');



  p {
    color: white;
    font-family: 'Open Sans', sans-serif;
    font-size: 20;
    font-weight: bold;
  }

  a {
    /* color: white; */
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    text-decoration: none;
  }

  span {
    font-family: 'Open Sans', sans-serif;
    font-size: 10;
  }
</style>