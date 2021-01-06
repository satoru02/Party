<template>
  <div>
    <p>{{ entry_response.answer }}</p>
  </div>
</template>

<script>
  import { simpleAxios, secureAxios } from "../../backend/axios"
  const ENTRY_RESPONSE_URL = `/api/v1/entry_responses`

  export default {
    name: 'EntryReponse',
    props: {
      entry_response_id: Number
    },
    data() {
      return{
        entry_response: ''
      }
    },
    created(){
      this.getEntryResponse()
    },
    methods: {
      getEntryResponse() {
        simpleAxios.get(ENTRY_RESPONSE_URL + `/` + `${this.entry_response_id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.entry_response = response.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>