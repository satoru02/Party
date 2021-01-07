<template>
  <div>
    <p>{{ entry_response.answer }}</p>
  </div>
</template>

<script>
  export default {
    name: 'EntryReponse',
    props: {
      entry_response: Object
    }
  }
</script>