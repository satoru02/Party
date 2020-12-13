<template>
  <div>
    <v-container class="mt-10">
      <v-row no-gutters>
        <v-col class="mb-7 pr-8" v-for="post in posts" :key="post.id" :title="post.title" :url="post.url"
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
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'card',
    props: {
      title: {
        status: {
          type: String,
          required: true,
        }
      },
      url: {
        status: {
          type: String,
          required: true,
        }
      },
      time: {
        status: {
          type: String,
          required: true,
        }
      },
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