<template>
  <v-textarea
    v-model="value"
    @input="$emit('input', $event)"
    :placeholder="childValue"
    outlined
    filled
  />
</template>

<script>
export default {
  name: "BaseTextArea",
  props: {
    childValue: '',
  },
  data(){
    return {
      value: ''
    }
  }
}
</script>