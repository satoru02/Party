<template>
  <v-responsive :posts="posts" class="overflow-y-auto flex-grow-1 flex-shrink-0" style="max-width: 100%;" height="600">
    <div v-for="(post, index) in posts" :key="index">
      <v-sheet color="#11151c" class="rounded-lg" width="740"
        style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 150px; max-width: 100%; max-height:1000px;">
        <v-row>
          <v-col cols=12 md=2 class="ml-7 mt-1" color="#efeff1">
            <v-btn small color="#2d00f7">イベント</v-btn>
          </v-col>
          <!-- <v-col cols=12 md=3 class="ml-n13 mt-1" color="#efeff1">{{ post.title }}</v-col> -->
          <v-col cols=12 md=3 class="ml-n10 mt-2" color="#efeff1">
            <h3>ワンダビジョン鑑賞会</h3>
          </v-col>
          <v-col cols=12 md=2 class="mt-1" color="#efeff1">
            <v-btn small color="#2d00f7">開催日</v-btn>
          </v-col>
          <!-- <v-col cols=12 md=2 class="ml-n16 mt-1" color="#efeff1">{{ postTime() }}</v-col> -->
          <v-col cols=12 md=5 class="ml-n13 mt-2" color="#efeff1">
            <h3>2021年12月24日（火）13:00〜14:30</h3>
          </v-col>
        </v-row>
        <v-divider></v-divider>
        <v-row>
          <v-col cols=12 md=11 class="ml-7 mt-3">
            <p style="color:#efeff1; font-size:0.8rem;">
              1979年イスラム革命前夜、西欧文化を否定する暴徒による。参加人数参加人数
              1979年イスラム革命前夜、西欧文化を否定する暴徒による。参加人数参加人数
              1979年イスラム革命前夜、西欧文化を否定する暴徒による。参加人数参加人数
              1979年イスラム革命前夜、西欧文化を否定する暴徒による。参加人数参加人数
            </p>
          </v-col>
          <v-col cols=12 md=1></v-col>
        </v-row>
        <v-row class="mt-n3">
          <v-col cols=12 md="3" class="ml-7 mt-n6">
            <p style="color:#efeff1; font-size:0.8rem;">
              <v-icon small>mdi-account-multiple-outline</v-icon> 参加人数
            </p>
          </v-col>
          <v-col cols=12 md="3" class="mt-n6">
            <p style="color:#efeff1; font-size:0.8rem;">15人</p>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=12 md="3" class="ml-7 mt-n6">
            <p style="color:#efeff1; font-size:0.8rem;">
              <v-icon small>mdi-door-open</v-icon> カテゴリー
            </p>
          </v-col>
          <v-col cols=12 md="3" class="mt-n6">
            <p style="color:#efeff1; font-size:0.8rem;">Movie</p>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=12 md="3" class="ml-7 mt-n6">
            <p style="color:#efeff1; font-size:0.8rem;">
              <v-icon small>mdi-laptop</v-icon> 使用ツール
            </p>
          </v-col>
          <v-col cols=12 md="5" class="mt-n6">
            <p style="color:#efeff1; font-size:0.8rem;">Zoom Youtube Twitch Twitter ChatRoom</p>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=12 md="3" class="ml-7 mt-n6">
            <p style="color:#efeff1; font-size:0.8rem;">
              <v-icon small>mdi-comment-outline</v-icon> 主催者からのコメント
            </p>
          </v-col>
          <v-col cols=12 md="6" class="mt-n6">
            <p style="color:#efeff1; font-size:0.8rem;">悪口禁止
            </p>
          </v-col>
        </v-row>
        <v-row class="tag mt-n3 ml-n9">
          <v-col cols=12 md=1></v-col>
          <div v-for="(n,index) in items" :key="index">
            <v-col cols=12 md=1 class="ml-n4">
              <v-btn depressed class="rounded-s" x-small color="#46494c">
                {{ n }}
              </v-btn>
            </v-col>
          </div>
        </v-row>
      </v-sheet>
      <p></p>
    </div>
  </v-responsive>

</template>

<script>
  import moment from 'moment';

  export default {
    name: "eventCard",
    props: {
      posts: Array
    },
    data() {
      return {
        items: [
          "#Game",
          "#素敵な春",
          "#Action",
          "#over 12",
          "#clush",
        ]
      }
    },
    postTime(time) {
      return moment(time).format("YYYY/MM/DD hh:mm")
    }
  }
</script>