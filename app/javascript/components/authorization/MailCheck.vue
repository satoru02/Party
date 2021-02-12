<template>
  <div justify="center" align="center">
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=10 lg=6 xl=6>
        <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1); width:auto; height:auto; min-height:200;" color="#212529"
          class="rounded-lg mt-16">
          <v-row>
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 />
            <v-col cols=8 sm=8 md=8 lg=8 xl=8 class="mt-8">
              <h2>メールボックスを確認してみてください。</h2>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=2 sm=2 md=2 lg=2 xl=2 />
            <v-col cols=8 sm=8 md=8 lg=8 xl=8 class="mt-4">
              <h3>{{ this.email }}へメールが届いています！</h3>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
    </v-row>
  </div>
</template>

<script>
  export default {
    name: 'MailCheck',
    data() {
      return {
        email: ''
      }
    },
    created() {
      this.checkSignedIn()
      this.email = this.$route.params.email
    },
    methods: {
      checkSignedIn() {
        if (this.$store.state.signedIn) {
          this.$router.replace('/')
        }
      }
    }
  }
</script>