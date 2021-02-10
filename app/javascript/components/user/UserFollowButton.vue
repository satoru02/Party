<template>
  <v-btn
    :class="roundClass"
    :style="followed ? followingStyle : followStyle"
    @click="followed ? unFollow(user_id) : follow(user_id)"
    dark>
  {{ followed ? folllowingText : followText }}
</v-btn>
</template>

<script>
import { secureAxios } from '../../backend/axios';
const RELATIONSHOP_URL = `/api/v1/relationships`

export default {
  name: "UserFollowButton",
  props: {
    followed: {
      type: Boolean,
      default: false,
    },
    user_id: {
      type: Number,
    }
  },
  data(){
    return {
      roundClass: {
        rounded: "lg"
      },
      folllowingText: 'Following',
      followingStyle: {
        backgroundColor: "#343a40",
        fontWeight: "bold",
        width: 80,
        height: 25
      },
      followText: 'Follow',
      followStyle: {
        backgroundColor: "#2d00f7",
        fontWeight: "bold",
        width: 80,
        height: 25
      },
    }
  },
  methods:{
    follow(user_id){
      secureAxios.post(RELATIONSHOP_URL, {
        followed_id: user_id
      })
      .then(response => {
        this.$store.commit('follow', user_id)
        this.followed = true
      })
    },
    unFollow(user_id){
      secureAxios.delete(RELATIONSHOP_URL + `/` + `${this.$store.state.currentUser.data.attributes.id}`, {
        params: {
          id: this.$store.state.currentUser.data.attributes.id,
          followed_id: user_id
        }
      })
      .then(response => {
        this.$store.commit('unfollow', user_id)
        this.followed = false
      })
    }
  }
}
</script>