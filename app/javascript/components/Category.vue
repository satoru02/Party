<template>
  <div infinite-wrapper>
    <category-post></category-post>
  </div>
</template>

<script>
import CategoryPosts from './CategoryPosts.vue'

export default {
  name: "category",
  components: {
    'category-post': CategoryPosts
  }
}
</script>