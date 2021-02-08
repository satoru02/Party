<template>
  <v-footer padless color="#212529" height="60">
    <v-row justify="center" no-gutters>
      <v-col cols=12 md=6 />
      <v-col cols=12 md=6 class="mr-n14">
      <v-btn
        v-for="(n, index) in items"
        :key="index"
        color="#979dac"
        text
        rounded
        class="my-2">
        {{ n }}
      </v-btn>
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
export default {
  name: "info-footer",
  data() {
    return {
      items: {
        strong: new Date().getFullYear() + "C",
        about: "質問・問い合わせ",
        help: "プライバシーポリシー",
        rule: "利用規約",
        raw: "特定商取引法に関する表記",
        developer: "運営者",
      }
      }
    }
  }
</script>