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

    <v-col cols=12 sm=12 md=6 lg=6 xl=6 class=".d-flex">
      <v-row>
        <v-col lg=1 class=".d-md-none .d-lg-flex" />
        <v-col v-if="$route.name === 'Top'" v-model="date" cols=12 sm=12 md=12 lg=4 xl=5>
          <h3>最新のイベント</h3>
        </v-col>
        <v-col v-if="$route.name === 'TopFilter'" v-model="date" cols=12 sm=12 md=12 lg=4 xl=5>
          <h3>{{date}}のイベント</h3>
        </v-col>
        <v-col v-if="$route.name === 'Category'" cols=12 sm=12 md=12 lg=4 xl=5>
          <h3>カテゴリー：{{this.$route.params.slug}}</h3>
        </v-col>
        <v-col v-if="$route.name === 'Search'" cols=12 sm=12 md=12 lg=4 xl=5>
          <h3>検索結果：{{this.$route.params.query}}</h3>
        </v-col>
        <v-col v-if="$route.name === 'Tag'" cols=12 sm=12 md=12 lg=4 xl=5>
          <h3>タグ：{{this.$route.params.name}}</h3>
        </v-col>
        <v-col md=1 class=".d-none .d-md-flex .d-lg-none" />
        <v-col cols=1 class=".d-flex .d-sm-none" />
        <v-col cols=2 sm=2 md=2 lg=1 xl=1 class="mt-1 ml-1">
          <router-link :to="{name: 'Top'}">
            <v-btn @click="condition = 'Top'" :style="[condition === 'Top' ? pushedStyles : buttonStyles]"
              class="rounded-xl" small elevation=0>
              <h3 :style="[condition === 'Top' ? pushedTextStyles : buttonTextStyles]">最新</h3>
            </v-btn>
          </router-link>
        </v-col>
        <v-col cols=2 sm=2 md=2 lg=1 xl=1 class="mt-1 ml-1">
          <v-btn @click="filterSearch(today), condition = 'today'"
            :style="[condition === 'today' ? pushedStyles : buttonStyles]" class="rounded-xl" small elevation=0>
            <h3 :style="[condition === 'today' ? pushedTextStyles : buttonTextStyles]">今日</h3>
          </v-btn>
        </v-col>
        <v-col cols=2 sm=2 md=2 lg=1 xl=1 class="mt-1 ml-1">
          <v-btn @click="filterSearch(week), condition = 'week'"
            :style="[condition === 'week' ? pushedStyles : buttonStyles]" small class="rounded-xl" elevation=0>
            <h3 :style="[condition === 'week' ? pushedTextStyles : buttonTextStyles]">今週</h3>
          </v-btn>
        </v-col>
        <v-col cols=2 sm=2 md=2 lg=1 xl=1 class="mt-1 ml-1">
          <v-btn @click="filterSearch(month), condition = 'month'"
            :style="[condition === 'month' ? pushedStyles : buttonStyles]" small class="rounded-xl" elevation=0>
            <h3 :style="[condition === 'month' ? pushedTextStyles : buttonTextStyles]">今月</h3>
          </v-btn>
        </v-col>
      </v-row>
      <router-view />
    </v-col>

    <v-col md=2 lg=2 xl=2 class="hidden-xs-only hidden-sm-only">
      <v-row class="mb-4 mt-4">
        <top-users />
      </v-row>
      <v-row>
        <v-sheet class="rounded-lg" width=340 height=520 color="#11151c" elevation=4
          style="height:auto; min-height: 520px; max-width: 100%; max-height:1000px;">
          <v-row>
          </v-row>
          <v-row class="mt-n5">
          </v-row>
        </v-sheet>
      </v-row>
    </v-col>
    <v-col md=1 lg=1 xl=1 />
  </v-row>
</template>

<script>
  import TopCategoryHeader from '../../components/top/TopCategoryHeader';
  import TopTagHeader from '../../components/top/TopTagHeader';
  import TopUsers from '../../components/top/TopUsers';

  export default {
    name: 'TopPage',
    components: {
      'top-category-header': TopCategoryHeader,
      'top-tag-header': TopTagHeader,
      'top-users': TopUsers
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