<template>
  <div>
    <div v-if="notification.classification === 'entry'">
      <entry :title='requested_post_information.title' :email="requested_user_information.email"
        :entry_id='requested_entry_information.id' :post_id="requested_post_information.id"
        :user_id='requested_user_information.id'></entry>
    </div>
    <div v-if="notification.classification === 'entryResponse'">
      <entryResponse :entry_response_id='notification.entry_response_id'></entryResponse>
    </div>
  </div>
</template>

<script>
  import Entry from '../components/notification/entry';
  import EntryResponse from '../components/notification/entryResponse';
  import { simpleAxios, secureAxios } from "../backend/axios"
  const NOTIFICATION_URL = `/api/v1/notifications`

  export default {
    name: 'Notification',
    components: {
      'entry': Entry,
      'entryResponse': EntryResponse
    },
    data() {
      return {
        notification: '',
        requested_entry_information: '',
        requested_entry_response_information: '',
        requested_post_information: '',
        requested_user_information: '',
      }
    },
    created() {
      this.getNotification()
    },
    methods: {
      getNotification() {
        simpleAxios.get(NOTIFICATION_URL + `/` + `${this.$route.params.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.notification = response.data[0].Notification
        this.requested_entry_information = response.data[0].Entry
        this.requested_entry_response_information = response.data[0].EntryResponse
        this.requested_post_information = response.data[0].Post
        this.requested_user_information = response.data[0].User
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>