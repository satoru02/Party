<template>
  <div>
    <!-- <v-container class="mt-n3"> -->
      <div id="slides">
        <div class="overlay"></div>
        <div class="slides-container">
          <img class="top" src="../packs/slide1.jpg" alt="">
          <p>SUNSET</p>
        </div>
        <div class="titleMessage">
          <div class="heading">
            <p class="main"></p>
            <p class="sub typed"></p>
          </div>
        </div>
        <nav class="slides-navigation">
          <a href="#" class="next"></a>
          <a href="#" class="prev"></a>
        </nav>
      </div>
    <!-- </v-container> -->
  </div>
</template>

<script>

</script>

<style>
img.top {
  width: 1500px;
  height: 650px;
  opacity: 0.2;
  padding-left: -730px;
  /* margin-right: 300px; */
}

.top::after{
    content: '';
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-color: rgb(0, 162, 255);
    opacity: 0.5;
    display:block
}
</style>