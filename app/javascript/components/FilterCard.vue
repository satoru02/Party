<template>
  <div infinite-wrapper>
    <card :posts="posts"></card>
    <infinite-loading spinner="spiral" @infinite="infiniteHandler"></infinite-loading>
  </div>
</template>

<script>
  import { secureAxios } from '../backend/axios';
  import Avatar from '../components/page/TheAvatar.vue';
  import InfiniteLoading from 'vue-infinite-loading';
  import Card from '../components/Card';

  export default {
    name: 'FilterCard',
    components: {
      'avatar': Avatar,
      'infinite-loading': InfiniteLoading,
      'card': Card
    },
    data() {
      return {
        page: 1,
        pageSize: 9,
        posts: [],
      }
    },
    watch: {
      '$route': {
        immediate: true,
        handler() {
          this.initialize()
          this.infiniteHandler()
        }
      }
    },
    methods: {
      initialize() {
        this.page = 1
        this.posts = []
      },
      infiniteHandler($state) {
        secureAxios.get(this.apiUrl(), { params: this.apiParams()})
          .then((res) => {
            setTimeout(() => {
              if (res.data.data.length) {
                this.page += 1;
                this.posts.push(...res.data.data);
                $state.loaded();
              } else {
                $state.complete();
              }
            }, 100)
          })
      },
      apiUrl(){
        if(this.$route.name === "Top"){
          return '/api/v1/posts'
        } else if(this.$route.name === "TopFilter"){
          return '/api/v1/posts/search'
        } else if(this.$route.name === "Category"){
          return '/api/v1/categories' + `/` + `${this.$route.params.slug}`
        } else if(this.$route.name === "Search"){
          return '/api/v1/posts/search'
        } else if(this.$route.name === "Tag"){
          return '/api/v1/tags' + `/` + `${this.$route.params.name}`
        }
      },
      apiParams(){
        var basic_params = { page: this.page, per_page: this.pageSize, user_id: `${this.$store.state.currentUser.data.attributes.id}` }
        if(this.$route.name === "Top"){
          var params = { position: 'top' }
          return Object.assign(basic_params, params)
        } else if(this.$route.name === "TopFilter"){
          var params = { filter_category: 'date', q: this.$route.params.query }
          return Object.assign(basic_params, params)
        } else if(this.$route.name === "Search"){
          var params = { filter_category: 'title', q: this.$route.params.query }
          return Object.assign(basic_params, params)
        } else if(this.$route.name === "Tag"){
          return basic_params
        } else if(this.$route.name === "Category"){
          return basic_params
        }
      }
    },
  }
</script>

<style scoped>
  .tile {
    margin: 10px;
    border-radius: 7px;
  }

  .tile:hover {
    background: #6c757d;
  }
</style>