<template>
    <div justify="center" align="center">
    <v-sheet color="#eaf4f4" height="550" class="rounded-xl" width="650">
      <v-row>
        <v-col cols="12" md="12" class="mt-12">
          <h1 style="color:black;">{{ entry_response.answer }}</h1>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" md="2">
          <avatar></avatar>
        </v-col>
        <v-col cols="12" md="2" class="mt-4 ml-n13">
          <h3 style="color:black;">user name</h3>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" md="1">
        </v-col>
        <v-col cols="12" md="10" class="mt-5">
          <p style="color:black; font-size: 1.0rem;">
            [理由]今回のイベントは定員に達したため
          </p>
        </v-col>
      </v-row>
      <!-- <v-row>
        <v-col cols=12 md=12 class="mt-16">
          <v-icon color="#6c757d">mdi-arrow-right</v-icon>
        </v-col>
      </v-row> -->
      <v-row>
        <v-col cols=12 md=10>
        </v-col>
        <v-col cols=12 md=2 class="mt-16">
          <h3 style="color:black; font-size: 0.5rem">03/21 12:00</h3>
        </v-col>
      </v-row>
    </v-sheet>
  </div>
</template>

<script>
  import Avatar from '../perpage/TheAvatar';
  export default {
    name: 'EntryReponse',
    components: {
      'avatar': Avatar
    },
    props: {
      entry_response: Object
    }
  }
</script>