import { createApp } from 'vue'
import App from './App.vue'
import router from './router' 
import store from './store';



const app = createApp(App);
app.use(router);
app.use(store);
app.config.globalProperties.$hostname = 'http://localhost:8081'; //change this url, when in production mode
app.mount('#app');
  
