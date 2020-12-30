<template>
<div>
  <router-link :to="{ name: 'Category', params: {id: 1 }}">SF</router-link>
  <router-link :to="{ name: 'Category', params: {id: 2 }}">Comedy</router-link>
  <router-link :to="{ name: 'Category', params: {id: 3 }}">Drama</router-link>
  <router-link :to="{ name: 'Category', params: {id: 4 }}">Documentary</router-link>
</div>
</template>

<script>
export default {
  name: "Category-Link"
}
</script>