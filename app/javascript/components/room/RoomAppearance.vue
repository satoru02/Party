<template>
<div>
  <v-badge
    v-if="this.icon === true"
    dot
    left
    inline
    color="#2176ff" />
</div>
</template>

<script>

  export default {
    name: "RoomAppearance",
    data() {
      return {
        icon: false
      }
    },
    channels: {
      AppearanceChannel: {
        connected() {},
        rejected() {},
        received(data) {
          if (data["user_id"] === this.$store.state.currentUser.data.attributes.id){
            this.icon = true
          } else {
            this.icon = false
          }
        },
        disconnected() {}
      }
    },
    mounted() {
      this.$cable.subscribe({
        channel: 'AppearanceChannel'
      })
    }
  }
</script>