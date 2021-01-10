<template>
<!-- 既読も未読も全て確認できる。Gメール的 -->
<div>
  <tbody>
    <tr v-for="notification in notifications" :key="notification.id">
      <router-link :to="{ name: 'Notification', params: {id: `${notification.id }`}}">
        <th>{{ notification.classification }}</th>
      </router-link>
    </tr>
  </tbody>
</div>
</template>

<script>
import { simpleAxios } from '../backend/axios';
const NOTIFICATIONS_URL = `/api/v1/notifications`

export default {
  name: 'Notifications',
  data() {
    return {
      notifications: []
    }
  },
  created() {
    this.getNotifications()
  },
  methods: {
    getNotifications() {
      simpleAxios.get(NOTIFICATIONS_URL)
      .then(response => this.Successful(response))
      .catch(error => this.Failed(error))
    },
    Successful(response) {
      this.notifications = response.data
    },
    Failed() {
      this.error = (error.response && error.response.data && error.response.data.error) || ""
    }
  }
}
</script>