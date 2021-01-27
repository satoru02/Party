<template>
  <div class="homes">
    <categoryHeader></categoryHeader>
    <div class="card" style="grid-area:card">
      <v-row>
        <v-col cols=12 md=12></v-col>
      </v-row>
      <v-row>
        <v-col v-model="date" cols=12 md=4 class="ml-5">
          <h1>{{date}}のイベント</h1>
        </v-col>
        <v-col cols=12 md=2></v-col>
        <v-col cols=12 md=1 class="ml-2 mt-1">
          <router-link :to="{name: 'Top'}">
            <v-btn color="#343a40" rounded-s small>
              <h3 style="color:#e9ecef; font-size:1rem;">最新</h3>
            </v-btn>
          </router-link>
        </v-col>
        <v-col cols=12 md=1 class="ml-3 mt-1">
          <v-btn @click="filterSearch(today)" color="#343a40" rounded-s small>
            <h3 style="color:#e9ecef; font-size:1rem;">今日</h3>
          </v-btn>
        </v-col>
        <v-col cols=12 md=1 class="ml-3 mt-1">
          <v-btn @click="filterSearch(week)" color="#343a40" small rounded-s>
            <h3 style="color:#e9ecef; font-size:1rem;">今週</h3>
          </v-btn>
        </v-col>
        <v-col cols=12 md=1 class="ml-3 mt-1">
          <v-btn @click="filterSearch(month)" color="#343a40" small rounded-s>
            <h3 style="color:#e9ecef; font-size:1rem;">今月</h3>
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
  import CategoryHeader from '../components/CategoryHeader';
  import TagHeader from '../components/TagHeader';

  export default {
    name: 'Top',
    components: {
      'categoryHeader': CategoryHeader,
      'tagHeader': TagHeader
    },
    data() {
      return {
        today: {
          identifier: 'today',
          date: ''
        },
        week: {
          identifier: 'week',
          date: ''
        },
        month: {
          identifier: 'month',
          date: ''
        },
        date: '最新'
      }
    },
    watch: {
      '$route.params.query': {
        immediate: true,
        handler() {
          this.dateChange()
        }
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
      filterSearch(value) {
        this.$router.replace({
          name: "TopFilter",
          params: {
            query: value.identifier
          }
        })
      },
      dateChange() {
        this.date = this.setDateName(this.$route.params.query)
      },
      setDateName(date) {
        if (date === 'today') {
          return '今日';
        } else if (date === 'week') {
          return '今週';
        } else if (date === 'month') {
          return '今月';
        } else {
          return '最新';
        }
      },
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
    grid-template-columns: 340px 810px 333px;
    grid-template-areas: "category card list""tag card list";
    grid-template-rows: 425px auto;
  }
</style>