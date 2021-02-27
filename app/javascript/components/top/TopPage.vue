<template>
  <v-row>
    <v-col md=1 lg=1 xl=1 />
    <v-col md=2 lg=2 xl=2 class="hidden-xs-only hidden-sm-only ml-n6">
      <v-row>
        <v-col md=12 lg=12 xl=12>
          <top-category-header v-if="$store.state.signedIn" />
        </v-col>
      </v-row>
      <v-row>
        <v-col md=12 lg=12 xl=12>
          <top-tag-header v-if="$store.state.signedIn" />
        </v-col>
      </v-row>
    </v-col>

    <v-col cols=12 sm=12 md=6 lg=6 xl=6 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-0': 'mt-n9']">
      <v-row>
        <v-col v-if="$route.name === 'Top'" v-model="date" cols=4 sm=12 md=12 lg=10 xl=10 align="start"
          class="ml-5 mb-n2">
          <div style="font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1 text-h6': 'subtitle-1']">Discover</div>
        </v-col>
        <v-col v-if="$route.name === 'TopFilter'" v-model="date" cols=4 sm=12 md=12 lg=10 xl=10 align="start"
          class="ml-5 mb-n2">
          <div style="font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1 text-h6': 'subtitle-1']">{{date}}のイベント</div>
        </v-col>
        <v-col v-if="$route.name === 'Category'" cols=4 sm=12 md=12 lg=10 xl=10 align="start" class="ml-5 mb-n2">
          <div style="font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1 text-h6': 'subtitle-1']">{{this.$route.params.slug}}</div>
        </v-col>
        <v-col v-if="$route.name === 'Search'" cols=4 sm=12 md=12 lg=10 xl=10 align="start" class="ml-5 mb-n2">
          <div style="font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1 text-h6': 'subtitle-1']">検索結果：{{this.$route.params.query}}</div>
        </v-col>
        <v-col v-if="$route.name === 'Tag'" cols=4 sm=12 md=12 lg=10 xl=10 align="start" class="ml-5 mb-n2">
          <div style="font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'mt-1 text-h6': 'subtitle-1']">#{{this.$route.params.name}}</div>
        </v-col>
        <v-col cols=4 class="hidden-lg-only hidden-xl-only" />
        <v-col xs=1 lg=1 xl=1 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-2 ml-n11': 'mt-0']">
          <v-menu offset-y>
            <template v-slot:activator="{on, attrs}">
              <v-btn elevation=0 small width="110" class="rounded-s" style="background-color:#21262d;" dark v-bind="attrs" v-on="on">
                Filter
                <v-icon small>mdi-chevron-down</v-icon>
                </v-btn>
            </template>
            <v-list>
              <v-list-item @click="filterSearch(item.name)" class="tile" v-for="(item, n) in items" :key="n">
                <v-list-item-title>{{ item.name }}</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        </v-col>
        <!-- <v-col md=1 />
        <v-col cols=1 lg=2 />
        <v-col cols=2 sm=2 md=2 lg=1 xl=1 class="ml-2">
          <router-link :to="{name: 'Top'}">
            <v-btn @click="condition = 'Top'" :style="[condition === 'Top' ? pushedStyles : buttonStyles]"
              class="rounded-xl" small elevation=0>
              <h3 :style="[condition === 'Top' ? pushedTextStyles : buttonTextStyles]">最新</h3>
            </v-btn>
          </router-link>
        </v-col>
        <v-col cols=2 sm=2 md=2 lg=1 xl=1 class="ml-2">
          <v-btn @click="filterSearch(today), condition = 'today'"
            :style="[condition === 'today' ? pushedStyles : buttonStyles]" class="rounded-xl" small elevation=0>
            <h3 :style="[condition === 'today' ? pushedTextStyles : buttonTextStyles]">今日</h3>
          </v-btn>
        </v-col>
        <v-col cols=2 sm=2 md=2 lg=1 xl=1 class="ml-2">
          <v-btn @click="filterSearch(week), condition = 'week'"
            :style="[condition === 'week' ? pushedStyles : buttonStyles]" small class="rounded-xl" elevation=0>
            <h3 :style="[condition === 'week' ? pushedTextStyles : buttonTextStyles]">今週</h3>
          </v-btn>
        </v-col>
        <v-col cols=2 sm=2 md=2 lg=1 xl=1 class="ml-2">
          <v-btn @click="filterSearch(month), condition = 'month'"
            :style="[condition === 'month' ? pushedStyles : buttonStyles]" small class="rounded-xl" elevation=0>
            <h3 :style="[condition === 'month' ? pushedTextStyles : buttonTextStyles]">今月</h3>
          </v-btn>
        </v-col> -->
      </v-row>
      <router-view />
    </v-col>

    <v-col md=2 lg=2 xl=2 class="hidden-xs-only hidden-sm-only">
      <v-row class="mb-4 mt-16">
        <top-popular-users />
      </v-row>
      <v-row>
        <top-popular-contents />
      </v-row>
    </v-col>
    <v-col md=1 lg=1 xl=1 />
  </v-row>
</template>

<script>
  import TopCategoryHeader from '../../components/top/TopCategoryHeader';
  import TopTagHeader from '../../components/top/TopTagHeader';
  import TopPopularUsers from '../../components/top/TopPopularUsers';
  import TopPopularContents from '../../components/top/TopPopularContents';

  export default {
    name: 'TopPage',
    components: {
      'top-category-header': TopCategoryHeader,
      'top-tag-header': TopTagHeader,
      'top-popular-users': TopPopularUsers,
      'top-popular-contents': TopPopularContents
    },
    data() {
      return {
        date: '最新',
        condition: 'Top',
        items: [
          // {name: '投稿日順'},
          {name: 'Today'},
          {name: 'Week'},
          {name: 'Month'},
        ],
        today: {
          identifier: 'Today',
          date: ''
        },
        week: {
          identifier: 'Week',
          date: ''
        },
        month: {
          identifier: 'Month',
          date: ''
        },
        pushedStyles: {
          backgroundColor: "#ff4800",
        },
        buttonStyles: {
          backgroundColor: "#343a40",
        },
        pushedTextStyles: {
          fontSize: "1rem",
          color: "#ffffff"
        },
        buttonTextStyles: {
          fontSize: "1rem",
          color: "#8b949e"
        }
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
      document.title = "Title - Title"
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn || localStorage.getItem('vuex') === null) {
          this.$router.replace('/login')
        }
      },
      filterSearch(target) {
        this.$router.replace({
          name: "TopFilter",
          params: {
            query: target
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

  .tile {
    margin: 10px;
    border-radius: 7px;
  }

  .tile:hover {
    background: #6c757d;
    cursor: pointer;
  }

  h2 {
    font-family: 'Montserrat', sans-serif;
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    color: #ffffff;
  }
</style>