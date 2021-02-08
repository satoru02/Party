<template>
  <div class="graph">
    <ul class="months">
      <li>Jan</li>
      <li>Feb</li>
      <li>Mar</li>
      <li>Apr</li>
      <li>May</li>
      <li>Jun</li>
      <li>Jul</li>
      <li>Aug</li>
      <li>Sep</li>
      <li>Oct</li>
      <li>Nov</li>
      <li>Dec</li>
    </ul>
    <ul>
    </ul>
    <ul class="squares">
      <cube v-for="year in years" :key="year.id" :date="year.date" :style="year.styleObject">
      </cube>
    </ul>
  </div>
</template>

<script>
  import {
    simpleAxios
  } from '../../backend/axios.js'
  import CUBE from '../user/UserCube';

  const DATE_URL = '/api/v1/years'
  const USERS_POSTS_URL = '/api/v1/users'

  export default {
    name: "UserLog",
    components: {
      'cube': CUBE
    },
    data() {
      return {
        years: '',
        active_logs: '',
      }
    },
    created() {
      this.getUsersPosts()
      this.getDate()
    },
    methods: {
      getUsersPosts() {
        simpleAxios.get(USERS_POSTS_URL + `/` + this.$route.params.id + `/posts`)
          .then(response => this.getsPostSuccessful(response))
          .catch(error => Failed(error))
      },
      getsPostSuccessful(response) {
        this.active_logs = JSON.parse(JSON.stringify(response.data))
      },
      getDate() {
        simpleAxios.get(DATE_URL)
          .then(response => this.getSuccessful(response))
          .catch(error => this.Failed(error))
      },
      getSuccessful(response) {
        this.years = JSON.parse(JSON.stringify(response.data))

        for (var i = 0; i < 365; i++) {
          var colorDate = this.active_logs.filter(active_log => active_log.date === this.years[i].date)
          if (colorDate.length === 1) {
            this.years[i].styleObject.backgroundColor = 'blue'
          }
        }
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>

<style>
  :root {
    --square-size: 9px;
    --square-gap: 4px;
    --week-width: calc(var(--square-size) + var(--square-gap));
  }

  ul,
  li {
    list-style-type: none;
  }

  .months {
    grid-area: months;
    font-size: 5px;
  }

  .days {
    grid-area: days;
  }

  .squares {
    grid-area: squares;
  }

  .graph {
    display: inline-grid;
    grid-template-areas: "empty months"
      "days squares";
    grid-template-columns: auto 1fr;
    grid-gap: 10px;
  }

  .months {
    display: grid;
    grid-template-columns: calc(var(--week-width) * 4)
      /* Jan */
      calc(var(--week-width) * 4)
      /* Feb */
      calc(var(--week-width) * 4)
      /* Mar */
      calc(var(--week-width) * 5)
      /* Apr */
      calc(var(--week-width) * 4)
      /* May */
      calc(var(--week-width) * 4)
      /* Jun */
      calc(var(--week-width) * 5)
      /* Jul */
      calc(var(--week-width) * 4)
      /* Aug */
      calc(var(--week-width) * 4)
      /* Sep */
      calc(var(--week-width) * 5)
      /* Oct */
      calc(var(--week-width) * 4)
      /* Nov */
      calc(var(--week-width) * 5)
      /* Dec */
    ;
  }

  .days,
  .squares {
    display: grid;
    grid-gap: var(--square-gap);
    grid-template-rows: repeat(7, var(--square-size));
  }

  .squares {
    grid-auto-flow: column;
    grid-auto-columns: var(--square-size);
  }

  body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
    font-size: 12px;
  }

  .graph {
    padding: 20px;
    border: 1px #d8d8d8;
    margin: 20px;
  }

  .days li:nth-child(odd) {
    visibility: hidden;
  }

  .squares li {
    background-color: #c4c4c4;
  }

  /* .squares li[data-level="1"] {
    background-color: #c6e48b;
  }

  .squares li[data-level="2"] {
    background-color: #7bc96f;
  }

  .squares li[data-level="3"] {
    background-color: #196127;
  } */
</style>