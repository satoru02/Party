<template>
<div>
  <tbody>
    <tr v-for="notification in notifications" :key="notification.id">
      <router-link :to="{ name: 'Notification', params: {id: `${notification.id }`}}">
        <!-- v-id stylebinding - confimarion -->
        <!-- modal -->
        <!-- <th>{{ notification.title }}</th>
        <th>{{ notification.type }}</th> -->
        <th>{{ notification.confirmation }}</th>
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