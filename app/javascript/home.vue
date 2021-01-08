<template>
  <div class="homes" infinite-wrapper>
    <!-- <about></about> -->
    <card></card>
  </div>
</template>

<script>
  import About from './components/perpage/TheAbout.vue';
  import Card from './components/card.vue';

  export default {
    name: 'Home',
    components: {
      'card': Card,
      'about': About,
    },
    created() {
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if(!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      }
    }
  }
</script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat&family=Open+Sans:wght@400;700&display=swap');

  p {
    color: white;
    font-family: 'Open Sans', sans-serif;
    font-size: 20;
    font-weight: bold;
  }

  a {
    font-family: 'Open Sans', sans-serif;
    font-weight: bold;
    text-decoration: none;
  }

  span {
    font-family: 'Open Sans', sans-serif;
    font-size: 10;
  }
</style>