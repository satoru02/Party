<template>
  <div>
    <v-row :class="[$vuetify.breakpoint.mdAndUp ? 'mt-15' : 'mt-5']">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <div v-if="notification.classification === 'entry'">
      <notification-entry
        :entry='entry_information'
        :post='requested_post_information'
        :user="requested_user_information"
      />
    </div>
    <div v-if="notification.classification === 'entryResponse'">
      <notification-entry-response
        :entry_response='entry_response_information'
      />
    </div>
    <div v-if="notification.classification === 'message'">
      <notification-message
        :message='message'
      />
    </div>
  </div>
</template>

<script>
  import { secureAxios } from "../../backend/axios";
  import NotificationEntry from '../../components/notification/NotificationEntry';
  import NotificationEntryResponse from '../../components/notification/NotificationEntryResponse';
  import NotificationMessage from '../../components/notification/NotificationMessage';
  const NOTIFICATION_URL = `/api/v1/notifications`

  export default {
    name: 'Notification',
    components: {
      'notification-entry': NotificationEntry,
      'notification-entry-response': NotificationEntryResponse,
      'notification-message': NotificationMessage
    },
    data() {
      return {
        notification: '',
        message: '',
        entry_response_information: '',
        entry_information: '',
        requested_post_information: '',
        requested_user_information: '',
      }
    },
    created() {
      this.checkSignedIn()
      this.getNotification()
    },
    methods: {
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
      },
      getNotification() {
        secureAxios.get(NOTIFICATION_URL + `/` + `${this.$route.params.id}`)
          .then(response => this.Successful(response))
          .catch(error => this.Failed(error))
      },
      Successful(response) {
        this.notification = response.data.data.attributes
        this.message = response.data.data.attributes
        this.entry_information = response.data.data.attributes.entry_info
        this.entry_response_information = response.data.data.attributes
        this.requested_post_information = response.data.data.attributes.post_info
        this.requested_user_information = response.data.data.attributes.user_info
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>