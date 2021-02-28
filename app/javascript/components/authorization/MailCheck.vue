<template>
  <div justify="center" align="center">
    <v-row style="height:180;">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=3 xl=3 />
      <v-col cols=10 sm=10 md=10 lg=6 xl=6>
        <v-sheet elevation=10 style="border: 1px solid hsla(0,0%,100%,.1); width:auto; height:auto; min-height:200;" color="#212529"
          class="rounded-lg mt-16">
          <v-row>
            <v-col cols=0 sm=2 md=2 lg=2 xl=2 />
            <v-col cols=12 sm=8 md=8 lg=8 xl=8 :class="[$vuetify.breakpoint.mdAndUp ? 'mt-8' : 'mt-4']">
              <div style="font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'text-h5' : 'sub-heading']">メールボックスを確認してみてください。</div>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=0 sm=2 md=2 lg=2 xl=2 />
            <v-col cols=12 sm=8 md=8 lg=8 xl=8>
              <div style="font-weight:bold;" :class="[$vuetify.breakpoint.mdAndUp ? 'text-h6' : 'sub-heading']">{{ this.email }}へメールが届いています！</div>
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
      document.title = "PartyKit - オンラインイベント告知サービス"
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