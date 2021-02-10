<template>
  <v-responsive
    class="overflow-y-auto flex-grow-1 flex-shrink-0"
    style="max-width: 100%;"
    height="700">
    <v-row style="width: 732px;" class="ml-1">
      <v-col cols=12 md=4 v-for="(user, index) in relationships" :key="index">
        <router-link :to="{ name: 'MyEvents', params: {id: user.id} }">
        <v-sheet
          class="rounded-lg"
          elevation=4
          width=222
          height=120
          color="#212529"
          style="border: 1px solid hsla(0,0%,100%,.1);">
          <v-row>
            <v-col cols=12 md=4 />
            <v-col cols=12 md=4>
              <base-avatar :size="50" />
            </v-col>
            <v-col cols=12 md=4 />
          </v-row>
          <v-row class="mt-n5">
            <v-col cols=12 md=3 />
            <v-col cols=12 md=5 class="ml-2">
              <p>{{ user.attributes.username }}</p>
            </v-col>
            <v-col cols=12 md=3 />
          </v-row>
        </v-sheet>
        </router-link>
      </v-col>
    </v-row>
  </v-responsive>
</template>

<script>
import BaseAvatar from '../../components/base/BaseAvatar';

export default {
  name: "UserRelationships",
  components: {
    'base-avatar': BaseAvatar
  },
  props: {
    relationships: {
      type: Array,
      required: true
    }
  }
}
</script>