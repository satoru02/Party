<template>
 <div>
   <th>{{ message }}</th>
 </div>
</template>

<script>
export default {
  name: "message",
  data() {
    return {
      message: ''
    }
  },
  // render: function(createElement) {
  //   var message = this.$slots.message
  //   return createElement('div', createElement('message', message))
  // }
}
</script>
