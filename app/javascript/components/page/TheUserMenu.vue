<template>
<v-row>
  <v-col sm=1 cols=1 md=1 lg=1 xl=1>
     <v-menu
      open-on-hover
      offset-y
      left
      nudge-top=5
      nudge-right=30
      nudge-height=800
      nudge-width=130>
      <template v-slot:activator="{ on, attrs }">
        <div v-bind="attrs" v-on="on" class="mt-3">
          <base-avatar
            :size="27"
            :avatar_url="avatar"/>
        </div>
      </template>
      <v-list class="rounded-s" style="background-color:#343a40;">
        <v-list-item
          class="tile"
          v-for="(item, index) in items"
          :key="index"
          :to="item.link"
          :icon="item.icon"
          link>
          <v-list-item-icon>
            <v-icon v-text="item.icon" />
          </v-list-item-icon>
          <v-list-item-title style="color:#ced4da">{{ item.title }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
  </v-col>
</v-row>
</template>

<script>
  import BaseAvatar from '../base/BaseAvatar.vue';
  export default {
    name: "TheUserMenu",
    components: {
      'base-avatar': BaseAvatar
    },
    data() {
      return {
        avatar: this.$store.state.currentUser.data.attributes.avatar_url,
        items: [{
            icon: 'mdi-account-outline',
            title: 'プロフィール',
            name: 'MyEvents',
            link: '/users/' + `${this.$store.state.currentUser.data.attributes.id}`,
          },
          {
            icon: 'mdi-garage-open',
            title: 'ルーム',
            link: '/rooms'
          },
          {
            icon: 'mdi-post-outline',
            title: 'アップロード',
            link: '/upload'
          },
          {
            icon: 'mdi-wrench-outline',
            title: '設定',
            link: '/users/' + `${this.$store.state.currentUser.data.attributes.id}` + '/settings'
          },
          {
            icon: 'mdi-help',
            title: 'ヘルプ',
            link: '/posts/new'
          },
          {
            icon: 'mdi-exit-run',
            title: 'ログアウト',
            link: '/logout'
          }
        ]
      }
    }
  }
</script>

<style scoped>
  .tile {
    margin: 10px;
    border-radius: 7px;
  }

  .tile:hover {
    background: #6c757d;
  }
</style>