<template>
  <div>
    <v-row class="mt-15">
      <v-col cols=12 md=12>
      </v-col>
    </v-row>
    <div v-if="notification.classification === 'entry'">
      <entry :entry='entry_information' :post='requested_post_information' :user="requested_user_information"></entry>
    </div>
    <div v-if="notification.classification === 'entryResponse'">
      <entry-response :entry_response='entry_response_information'></entry-response>
    </div>
    <div v-if="notification.classification === 'message'">
      <message :message='message'></message>
    </div>
  </div>
</template>

<script>
  import Entry from '../../components/notification/NotificationEntry';
  import EntryResponse from '../../components/notification/NotificationEntryResponse';
  import Message from '../../components/notification/NotificationMessage';
  import { secureAxios } from "../../backend/axios";
  const NOTIFICATION_URL = `/api/v1/notifications`

  export default {
    name: 'Notification',
    components: {
      'entry': Entry,
      'entry-response': EntryResponse,
      'message': Message
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