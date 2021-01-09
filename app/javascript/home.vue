<template>
  <div class="homes">
    <categoryHeader></categoryHeader>
    <!-- <v-divider vertical></v-divider> -->
    <card></card>
        <v-divider dark vertical></v-divider>
    <div class="list">
      <v-container ></v-container>
    </div>
  </div>
</template>

<script>
  import Card from './components/card.vue';
  import CategoryHeader from './components/CategoryHeader';

  export default {
    name: 'Home',
    components: {
      'card': Card,
      'categoryHeader': CategoryHeader
    },
    created() {
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      }
    }
  }
</script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat&family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

  p {
    color: white;
    /* font-family: 'Open Sans', sans-serif; */
    font-family: 'Roboto', sans-serif;

    font-size: 20;
    font-weight: bold;
  }

  a {
    /* font-family: 'Open Sans', sans-serif; */
    font-family: 'Roboto', sans-serif;
    font-weight: bold;
    text-decoration: none;
  }

  span {
    /* font-family: 'Open Sans', sans-serif; */
    font-family: 'Roboto', sans-serif;

    font-size: 10;
  }

  .homes {
    display: grid;
    grid-template-columns: 334px auto 408px;
    grid-template-areas: "category card list";
  }
</style>