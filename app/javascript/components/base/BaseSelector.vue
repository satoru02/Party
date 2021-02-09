<template>
 <v-select
   v-model="value"
   @input="$emit('select', $event)"
   :placeholder="selectorText"
   :items="childItems"
   item-text="name"
   dense
   filled
   outlined
  />
</template>

<script>
export default {
  name: "BaseSelector",
  props: {
    selectorText: '',
    childItems: Array
  },
  data(){
    return {
      value: ''
    }
  }
}
</script>