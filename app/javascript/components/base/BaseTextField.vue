<template>
  <v-text-field
     v-model="value"
     @input="$emit('input', $event)"
     :placeholder="childValue"
     outlined
     dark
     filled
     dense
   />
</template>

<script>
export default {
  name: "BaseTextField",
  props: {
    childValue: '',
  },
  data(){
    return{
      value: ''
    }
  }
}
</script>