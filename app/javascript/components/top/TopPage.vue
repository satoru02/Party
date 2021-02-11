<template>
  <v-row>
    <v-col md=3 lg=3 xl=3 class="hidden-xs-only hidden-sm-only">
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

    <v-col cols=12 sm=12 md=7 lg=7 xl=7 class=".d-flex">
      <v-row>
        <v-col v-if="$route.name === 'Top'" v-model="date" cols=5 sm=5 md=5 lg=5 xl=5 class="ml-5">
          <h2>最新のイベント</h2>
        </v-col>
        <v-col v-if="$route.name === 'TopFilter'" v-model="date" cols=5 sm=5 md=5 lg=5 xl=5 class="ml-5">
          <h2>{{date}}のイベント</h2>
        </v-col>
        <v-col v-if="$route.name === 'Category'" cols=5 sm=5 md=5 lg=5 xl=5 class="ml-5">
          <h2>カテゴリー：{{this.$route.params.slug}}</h2>
        </v-col>
        <v-col v-if="$route.name === 'Search'" cols=5 sm=5 md=5 lg=5 xl=5 class="ml-5">
          <h2>検索結果：{{this.$route.params.query}}</h2>
        </v-col>
        <v-col v-if="$route.name === 'Tag'" cols=5 sm=5 md=5 lg=5 xl=5 class="ml-5">
          <h2>タグ：{{this.$route.params.name}}</h2>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="mt-1 ml-16">
          <router-link :to="{name: 'Top'}">
            <v-btn @click="condition = 'Top'" :style="[condition === 'Top' ? pushedStyles : buttonStyles]"
              class="rounded-xl" small elevation=0>
              <h3 :style="[condition === 'Top' ? pushedTextStyles : buttonTextStyles]">最新</h3>
            </v-btn>
          </router-link>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-2 mt-1">
          <v-btn @click="filterSearch(today), condition = 'today'"
            :style="[condition === 'today' ? pushedStyles : buttonStyles]" class="rounded-xl" small elevation=0>
            <h3 :style="[condition === 'today' ? pushedTextStyles : buttonTextStyles]">今日</h3>
          </v-btn>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-2 mt-1">
          <v-btn @click="filterSearch(week), condition = 'week'"
            :style="[condition === 'week' ? pushedStyles : buttonStyles]" small class="rounded-xl" elevation=0>
            <h3 :style="[condition === 'week' ? pushedTextStyles : buttonTextStyles]">今週</h3>
          </v-btn>
        </v-col>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-2 mt-1">
          <v-btn @click="filterSearch(month), condition = 'month'"
            :style="[condition === 'month' ? pushedStyles : buttonStyles]" small class="rounded-xl" elevation=0>
            <h3 :style="[condition === 'month' ? pushedTextStyles : buttonTextStyles]">今月</h3>
          </v-btn>
        </v-col>
      </v-row>
      <router-view />
    </v-col>

    <v-col md=2 lg=2 xl=2 class="ml-n16 hidden-xs-only hidden-sm-only">
      <v-row class="mb-4 mt-4">
        <v-sheet class="rounded-xl" width=320 height=400 color="#11151c"
          style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 220px; max-width: 100%; max-height:1000px;">
          <v-row>
          </v-row>
          <v-row class="mt-n5">
          </v-row>
        </v-sheet>
      </v-row>
      <v-row>
        <v-sheet class="rounded-xl" width=340 height=520 color="#11151c"
          style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 520px; max-width: 100%; max-height:1000px;">
          <v-row>
          </v-row>
          <v-row class="mt-n5">
          </v-row>
        </v-sheet>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
  import TopCategoryHeader from '../../components/top/TopCategoryHeader';
  import TopTagHeader from '../../components/top/TopTagHeader';

  export default {
    name: 'TopPage',
    components: {
      'top-category-header': TopCategoryHeader,
      'top-tag-header': TopTagHeader
    },
    data() {
      return {
        date: '最新',
        condition: 'Top',
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
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn || localStorage.getItem('vuex') === null) {
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
</style>