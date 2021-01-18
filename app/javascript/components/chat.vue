<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Rooms from '../components/Rooms';
import Room from '../components/Room';

export default {
  name: "Chat",
  components: {
    'rooms': Rooms,
    'room': Room
  }
}
</script>