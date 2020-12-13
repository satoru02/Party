<template>
  <div class="homes">
    <div>
      <v-container class="mt-10">
      </v-container>
    </div>
    <card></card>
    <!-- <post></post> -->
  </div>
</template>

<script>
  import post from './components/post.vue';
  import card from './components/card.vue';

  export default {
    name: 'home',
    components: {
      'post': post,
      'card': card,
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