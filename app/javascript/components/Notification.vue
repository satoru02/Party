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
    <div v-if="notification.classification === 'message'">
      <message :message_id='message.id'></message>
    </div>
  </div>
</template>

<script>
  import Entry from '../components/notification/entry';
  import EntryResponse from '../components/notification/entryResponse';
  import Message from '../components/notification/message';
  import { simpleAxios, secureAxios } from "../backend/axios"
  const NOTIFICATION_URL = `/api/v1/notifications`

  export default {
    name: 'Notification',
    components: {
      'entry': Entry,
      'entryResponse': EntryResponse,
      'message': Message
    },
    data() {
      return {
        notification: '',
        message: '',
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
        this.notification = response.data[0].notification
        this.message = response.data[0].message
        this.requested_entry_information = response.data[0].entry
        this.requested_entry_response_information = response.data[0].entry_response
        this.requested_post_information = response.data[0].post
        this.requested_user_information = response.data[0].user
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>