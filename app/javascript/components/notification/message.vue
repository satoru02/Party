<template>
  <div>
    <p>You git a{{ message.id }} in room </p>
  </div>
</template>

<script>
  export default {
    name: 'Message',
    props: {
      message: Object,
    }
  }
</script>