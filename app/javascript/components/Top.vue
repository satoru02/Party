<template>
  <div class="homes">
    <categoryHeader></categoryHeader>
    <div class="card" style="grid-area:card">
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
      <router-view></router-view>
    </div>
    <v-divider dark vertical></v-divider>
    <tagHeader></tagHeader>
    <v-divider dark vertical></v-divider>
  </div>
</template>

<script>
  import Avatar from '../components/perpage/TheAvatar.vue';
  import EventCard from '../components/EventCard';
  import CategoryHeader from '../components/CategoryHeader';
  import TagHeader from '../components/TagHeader';

  export default {
    name: 'Top',
    components: {
      'avatar': Avatar,
      'event-card': EventCard,
      'categoryHeader': CategoryHeader,
      'tagHeader': TagHeader
    },
    data() {
      return {
        page: 1,
        pageSize: 9,
        posts: [],
      }
    },
    created() {
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      filterSearch() {
        this.$router.replace({
          name: "TopFilter",
          params: {
            query: "today"
          }
        })
      }
    },
  }
</script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat&family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

  p {
    color: white;
    font-family: 'Roboto', sans-serif;
    font-size: 20;
    font-weight: bold;
  }

  a {
    font-family: 'Roboto', sans-serif;
    font-weight: bold;
    text-decoration: none;
  }

  span {
    font-family: 'Roboto', sans-serif;
    font-size: 10;
  }

  .homes {
    display: grid;
    grid-template-columns: 364px auto 372px;
    grid-template-areas: "category card list""tag card list";
    grid-template-rows: 425px auto;
  }
</style>