<template>
  <v-responsive
    class="overflow-y-auto flex-grow-1 flex-shrink-0"
    style="max-width: 100%;"
    height="1200">
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