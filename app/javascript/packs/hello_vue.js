import Vue from 'vue';
import App from '../app.vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
// import GETTILTE from '../mixin/getTitle';

Vue.use(Vuetify)
// Vue.mixin(GETTILTE)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    vuetify: new Vuetify({
      theme: { dark: true },
      customVariables: ['../src/overrides.scss']
    }),
  }).$mount()
  document.body.appendChild(app.$el)
})