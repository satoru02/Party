<template>
  <div class="homes">
    <categoryHeader></categoryHeader>
    <card></card>
    <v-divider dark vertical></v-divider>
    <tagHeader></tagHeader>
    <v-divider dark vertical></v-divider>
  </div>
</template>

<script>
  import Card from './components/card.vue';
  import CategoryHeader from './components/CategoryHeader';
  import TagHeader from './components/TagHeader';

  export default {
    name: 'Home',
    components: {
      'card': Card,
      'categoryHeader': CategoryHeader,
      'tagHeader': TagHeader
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