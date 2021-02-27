import Vue from 'vue';
import App from '../app.vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';

Vue.use(Vuetify)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    vuetify: new Vuetify({
      theme: { dark: true },
      customVariables: ['../src/overrides.scss']
    }),
  }).$mount()
  console.log(app.$el)
  document.body.appendChild(app.$el)
})