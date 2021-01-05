<template>
  <v-col id="icon" class="pa-2 mt-14 ml-n16 ">
    <v-icon>mdi-wifi</v-icon>
  </v-col>
</template>

<script>
import consumer from '../../channels/consumer.js';

const SUBSCRIBER = consumer.subscriptions.create({
  channel: "NotificationsChannel",
})

SUBSCRIBER.received = function(data) {
  console.log(data)
  // current_userとtarget_userの照合。
  // mail_notification_controllerでtarget_userにメール送信。
  // 赤い通知ボタンレンダリング。
  // クリックすると、notificatinon resourceに飛ぶ。
  // 通知は数で表示。
  // entry index 自分のエントリーに読んでないやつ表示 call api
    const html = `<th>${data["title"]}</th>`
    const element = document.querySelector('#icon')
    element.insertAdjacentHTML('beforeend', html)

}

export default {
  name: 'Notifications',
  data() {
    return {
    }
  }
}
</script>