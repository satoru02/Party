import Vue from 'vue';
import App from '../app.vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import colors from 'vuetify/lib/util/colors'

Vue.use(Vuetify)

export default new Vuetify({
  theme: { dark: true },
})

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    vuetify: new Vuetify(),
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})