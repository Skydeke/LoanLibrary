import { createWebHistory, createRouter } from 'vue-router'
import homePage from '../pages/homePage'
import loginPage from '../pages/loginPage'
import signupPage from '../pages/signupPage'
import vehiclePage from '../pages/vehiclePage'

const routes = [ 
    { path: '/', name:'home', component: homePage },
    { path: '/login',name:'login', component: loginPage},
    {path: '/vehicle/:id',name:'vehicle', component:vehiclePage }, //the name attribute is a reference we can use in code :vehicle_name is a URL Parameter for us (dynamic route matching)
    { path: '/signup',name:'signup', component: signupPage}
  ];



const router = createRouter({
history: createWebHistory(),
routes,
});


export default router;
