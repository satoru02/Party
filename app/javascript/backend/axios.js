import axios from 'axios'

const simpleAxios = axios.create({
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
});

const secureAxios = axios.create({
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
});

// secureAxios.interceptors.request.use(config => {
//   const method = config.method.toUpperCase()
//   if (method != 'OPTIONS' && method !== 'GET') {
//     config.headers = {
//       ...config.headers,
//       'X-CSRF-TOKEN': store.state.csrf
//     }
//   }
//   return config;
// });

export { simpleAxios, secureAxios }