import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  }, 
   {
    path: '/Trading',
    name: 'Trading',
    component: () => import('@/views/Trading.vue')
   },
   {
    path: '/My',
    name: 'My',
    component: () => import('@/views/My.vue')
   },
   
   {
    path: '/Direct',
    name: 'Direct',
    component: () => import('@/views/Direct.vue')
   },
   {
    path: '/Records',
    name: 'Records',
    component: () => import('@/views/Records.vue')
   },   





   
  

]

const router = new VueRouter({
  routes,
  scrollBehavior(to, from, savedPosition) {
    //设置回到顶部
    if (savedPosition) {
      return savedPosition;
    }
    return { x: 0, y: 0 };
  },
});

export default router
