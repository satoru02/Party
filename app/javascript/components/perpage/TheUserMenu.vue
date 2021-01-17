<template>
  <div class="text-center">
    <v-menu open-on-hover offset-y left nudge-bottom="2" nudge-left=62 nudge-height=600 nudge-width=130>
      <template v-slot:activator="{ on, attrs }">
        <div v-bind="attrs" v-on="on">
          <avatar :size="30" :avatar_url="avatar" class="mt-9 mr-16"></avatar>
        </div>
      </template>
      <v-list class="rounded-s" style="background-color:#343a40;">
        <v-list-item class="tile" v-for="(item, index) in items" :key="index" :to="item.link" :icon="item.icon" link>
          <v-list-item-icon>
            <v-icon v-text="item.icon"></v-icon>
          </v-list-item-icon>
          <v-list-item-title style="color:#ced4da">{{ item.title }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
  </div>
</template>

<script>
  import Avatar from './TheAvatar.vue';
  export default {
    name: "userMenu",
    components: {
      'avatar': Avatar
    },
    data() {
      return {
        avatar: this.$store.state.currentUser.data.attributes.avatar_url,
        items: [{
            icon: 'mdi-account-outline',
            title: 'Profile',
            link: '/users/' + `${this.$store.state.currentUser.data.attributes.id}`,
          },
          {
            icon: 'mdi-account-multiple-outline',
            title: 'Friends',
            link: '/posts/new'
          },
          {
            icon:  'mdi-garage-open',
            title: 'Rooms',
            link: '/rooms'
          },
          {
            icon:  'mdi-post-outline',
            title: 'Edit Post',
            link: '/posts/new'
          },
          {
            icon:  'mdi-wrench-outline',
            title: 'Settings',
            link: '/setting'
          },
          {
            icon:  'mdi-help',
            title: 'Help',
            link: '/posts/new'
          },
          {
            icon:  'mdi-exit-run',
            title: 'Sign out',
            link: '/posts/new'
          }
        ],
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