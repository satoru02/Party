<template>
  <v-responsive class="overflow-y-auto flex-grow-1 flex-shrink-0" style="max-width: 100%;" height="700">
    <v-row class="ml-1">
      <v-col cols=4 sm=4 md=4 lg=4 xl=4 v-for="(user, index) in relationships" :key="index">
        <router-link :to="{ name: 'Posts', params: {id: user.id} }">
          <v-sheet class="rounded-lg" elevation=4 color="#212529"
            style="border: 1px solid hsla(0,0%,100%,.1); width:auto; height:auto;">
            <v-row no-gutters>
              <v-col cols=1 sm=4 md=4 lg=4 xl=4 />
              <v-col cols=5 sm=4 md=4 lg=4 xl=4 align="center" class="mt-5">
                <base-avatar :size="60" :avatar_url="user.attributes.avatar_url" />
                <v-row no-gutters>
                  <v-col cols=4 sm=2 md=2 lg=2 xl=2 />
                  <v-col cols=2 sm=8 md=8 lg=8 xl=8 align="start" class="mt-3">
                    <p>{{ user.attributes.username }}</p>
                  </v-col>
                  <v-col cols=2 sm=2 md=2 lg=2 xl=2 />
                </v-row>
              </v-col>
              <v-col cols=1 sm=4 md=4 lg=4 xl=4 />
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