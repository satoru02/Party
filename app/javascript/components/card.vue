<template>
  <div class="card" style="grid-area:card" infinite-wrapper>
    <v-row class="mt-2">
      <v-col cols=12 md=6></v-col>
      <v-col cols=12 md=1 class="ml-n4">
        <v-btn @click="filterSearch()" color="#efeff1" text rounded>
          <div style="color:#efeff1; font-size:0.8rem;">Trend</div>
        </v-btn>
      </v-col>
      <v-col cols=12 md=1 class=ml-3>
        <v-btn @click="filterSearch()" color="#efeff1" text rounded>
          <div style="color:#efeff1; font-size:0.8rem;">Today</div>
        </v-btn>
      </v-col>
      <v-col cols=12 md=1 class=ml-3>
        <v-btn @click="filterSearch()" color="#efeff1" text rounded>
          <div style="color:#efeff1; font-size:0.8rem;">Week</div>
        </v-btn>
      </v-col>
      <v-col cols=12 md=1 class=ml-2>
        <v-btn @click="filterSearch()" color="#efeff1" text rounded>
          <div style="color:#efeff1; font-size:0.8rem;">Month</div>
        </v-btn>
      </v-col>
    </v-row>
    <event-card :posts="this.posts"></event-card>
    <infinite-loading spinner="spiral" @infinite="infiniteHandler"></infinite-loading>
  </div>
</template>

<script>
  import { simpleAxios } from '../backend/axios.js'
  import Avatar from '../components/perpage/TheAvatar.vue';
  import InfiniteLoading from 'vue-infinite-loading';
  import EventCard from '../components/EventCard';

  const CONTENT_URL = '/api/v1/posts'

  export default {
    name: 'Card',
    components: {
      'avatar': Avatar,
      'infinite-loading': InfiniteLoading,
      'event-card': EventCard,
    },
    props: {
      title: {
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
      user_id: {
        status: {
          type: String,
          required: true
        }
      }
    },
    data() {
      return {
        page: 1,
        pageSize: 9,
        posts: [],
      }
    },
    methods: {
      infiniteHandler($state) {
        simpleAxios.get(CONTENT_URL, {
            params: {
              position: 'top',
              page: this.page,
              per_page: this.pageSize,
              user_id: `${this.$store.state.currentUser.data.attributes.id}`,
            },
          })
          .then((res) => {
            setTimeout(() => {
              if (res.data.data.length) {
                this.page += 1;
                this.posts.push(...res.data.data);
                $state.loaded();
              } else {
                $state.complete();
              }
            }, 1000)
          })
      },
      filterSearch(value) {
        this.$router.replace({
          name: "TopFilter",
          params: {
            query: value
          }
        })
      }
    },
  }
</script>