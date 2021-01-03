import consumer from '../channels/consumer.js';

const SUBSCRIBER = consumer.subscriptions.create({
  channel: "RoomChannel",
  room: "room1"
})

SUBSCRIBER.received = function (data) {
  // const element = document.querySelector('#word')
  // element.insertAdjacentHTML('beforeend', data['message'])
  // this.insertMessage(data)
  // console.log(message)
}
