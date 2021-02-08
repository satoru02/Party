<template>
  <v-text-field
     @input="handleInput"
     outlined
     dark
     filled
     dense
   />
</template>

<script>
export default {
  name: "BaseTextField",
  prop: ['value'],
  data(){
    return {
      content: this.value
    }
  },
  methods: {
    handleInput(e){
      // console.log(this.value)
      console.log(this.content)
      console.log(this.$emit('input', this.content))
    }
  }
}
</script>