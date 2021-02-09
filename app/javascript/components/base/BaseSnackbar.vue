<template>
  <v-snackbar
    v-model="snackbar"
    top
    color="pink"
   >
   <div
     v-for="(text, index) in childValue"
     :key="index">
      {{ text }}
   </div>
   <template v-slot:action="{ attrs }">
     <v-btn
       v-bind="attrs"
       @click="$emit('click', value)"
       color="white"
       text>
       閉じる
     </v-btn>
   </template>
  </v-snackbar>
</template>

<script>
export default {
  name: "BaseSnackbar",
  props: {
    childValue: Array
  },
  data() {
    return {
      snackbar: true,
      value: false
    }
  }
}
</script>