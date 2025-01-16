import Vue from 'vue'
import 'lib-flexible'
import App from './App.vue'
import router from './router'
import store from './store'
import Vant from 'vant';
import 'vant/lib/index.css';
import VueI18n from "vue-i18n";
import axios from 'axios';
import Qs from 'qs'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import VueClipboard from 'vue-clipboard2'
import './plugins/rem'
import VueResizeText from 'vue-resize-text';
import './store/shax'

Vue.use(VueI18n)
const i18n = new VueI18n({
    locale: store.getters.language,    // 语言标识
    //this.$i18n.locale // 通过切换locale的值来实现语言切换
    messages: {
      'zh-CN': require('./lang/zh'),   // 中文语言包
      'en-US': require('./lang/en'),    // 英文语言包      
    }
})
Vue.use(VueResizeText)
VueClipboard.config.autoSetContainer = true
Vue.use(VueClipboard)
Vue.use(Vant);

Vue.config.productionTip = false

NProgress.configure({     
  easing: 'ease',  // 动画方式    
  speed: 500,  // 递增进度条的速度    
  showSpinner: false, // 是否显示加载ico    
  trickleSpeed: 200, // 自动递增间隔    
  minimum: 0.3 // 初始化时的最小百分比
})

router.beforeEach((to, from , next) => {
  // 每次切换页面时，调用进度条
  NProgress.start();
  next();
});



router.afterEach(() => {  
  // 在即将进入新的页面组件前，关闭掉进度条
  NProgress.done()
})
// function msd(e) {
//   let data = parseInt(new Date().getTime() / 1000) 
//   var h = md5(e + data + 'filplaywebcom')
//   return h
// }


new Vue({
  router,
  store,
  i18n,
  render: h => h(App)
}).$mount('#app')
