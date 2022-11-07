import { createWebHistory, createRouter } from 'vue-router'
import homePage from '../pages/homePage'
import loginPage from '../pages/loginPage'

const routes = [ 
    { path: '/', name:'home', component: homePage },
    { path: '/login',name:'login', component: loginPage}
  ];



const router = createRouter({
history: createWebHistory(),
routes,
});


export default router;
