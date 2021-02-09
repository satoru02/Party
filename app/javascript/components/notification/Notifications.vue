<template>
  <div infinite-wrapper>
    <v-container>
      <v-row justify="center" align="center">
        <v-col cols="12" md="10">
          <v-list color="#161a1d">
            <v-list-item-group>
              <h1 class="mb-5">Notifications</h1>
              <v-divider dark />
              <template v-for="(notification) in notifications">
                <router-link
                  :key="notification.attributes.id"
                  :to="{ name: 'Notification', params: {id: `${notification.attributes.id }`}}">
                  <v-list-item class="mt-3">
                    <v-list-item-action>
                      <v-badge
                        v-if="notification.attributes.confirmation === false"
                        dot
                        left
                        inline
                        color="#2176ff" />
                    </v-list-item-action>
                    <base-avatar
                    　:avatar_url="notification.attributes.index_user_info[0].avatar"
                    />
                    <v-list-item-content>
                      <v-list-item-subtitle
                        class="ml-7"
                        v-html="displayText(notification)" />
                    </v-list-item-content>
                    <v-list-item-action
                      style="font-size: 0.5rem; color:#6c757d;"
                      v-text="catchedTime(notification.attributes.created_at)" />
                  </v-list-item>
                </router-link>
              </template>
            </v-list-item-group>
          </v-list>
        </v-col>
      </v-row>
    </v-container>
    <infinite-loading
      spinner="spiral"
      @infinite="infiniteHandler"
    />
  </div>
</template>

<script>
  import { secureAxios } from "../../backend/axios";
  import BaseAvatar from '../base/BaseAvatar';
  import moment from 'moment';
  import InfiniteLoading from 'vue-infinite-loading';
  const NOTIFICATIONS_URL = `/api/v1/notifications`

  export default {
    name: 'Notifications',
    components: {
      'base-avatar': BaseAvatar,
      'infinite-loading': InfiniteLoading
    },
    data() {
      return {
        notifications: [],
        page: 1,
        pageSize: 9,
      }
    },
    created() {
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      infiniteHandler($state) {
        secureAxios.get(NOTIFICATIONS_URL, {
          params: {
            position: 'index',
            page: this.page,
            per_page: this.pageSize,
          },
        }).then((res) => {
          setTimeout(() => {
            if (res.data.data.length) {
              this.page += 1;
              this.notifications.push(...res.data.data);
              $state.loaded();
            } else {
              $state.complete();
            }
          }, 1000)
        })
      },
      catchedTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      },
      displayText(notification) {
        if (notification.attributes.classification === "entry") {
          return `${notification.attributes.index_user_info[0].user.name}さん` + "から、新しいエントリーが届いています！"
        } else if (notification.attributes.classification === "entryResponse") {
          return "イベントオーガナイザーの" + `${notification.attributes.index_user_info[0].user.name}さん` + "からメッセージが届きました！"
        } else {
          return "今週、注目のイベントをチェックしよう！"
        }
      },
    }
  }
</script>
