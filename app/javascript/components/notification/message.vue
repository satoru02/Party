<template>
  <div>
    <p>You git a{{ message_id }} in room </p>
  </div>
</template>

<script>
  // import { simpleAxios, secureAxios } from "../../backend/axios"
  // const MESSAGE_URL = `/api/v1/messages`

  export default {
    name: 'Message',
    props: {
      // message: Object,
      message_id: Number
    }
    // data() {
    //   return{
    //     message: ''
    //   }
    // },
    // created(){
    //   this.getMessage()
    // },
    // methods: {
    //   getMessage() {
    //     simpleAxios.get(MESSAGE_URL + `/` + `${this.message_id}`)
    //       .then(response => this.Successful(response))
    //       .catch(error => this.Failed(error))
    //   },
    //   Successful(response) {
    //     this.message = response.data
    //   },
    //   Failed(error) {
    //     this.error = (error.response && error.response.data && error.response.data.error) || ""
    //   }
    // }
  }
</script>