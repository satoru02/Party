<template>
  <div infinite-wrapper>
    <filter-post></filter-post>
  </div>
</template>

<script>
import FilterPosts from './FilterPosts.vue'

export default {
  name: "search",
  components: {
    'filter-post': FilterPosts
  }
}
</script>
