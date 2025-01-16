<template>
  <div id="app">
    <transition name="slide-fade" mode="out-in">
      <router-view v-if="shows" />
    </transition>
  </div>
</template>

<script>
export default {
  provide() {
    //父组件中通过provide来提供变量，在子组件中通过inject来注入变量。
    return {
      reload: this.reload,
    };
  },
  data() {
    return {
      shows: true,
    };
  },

  
  created() {},
  methods: {
    reload() {
      this.isRouterAlive = false; //先关闭，
      this.$nextTick(function () {
        this.isRouterAlive = true; //再打开
      });
    }
  },
};
</script>

<style lang="scss">
#app {
  background: #f8f8f8 !important;
}
::-webkit-scrollbar {
  width: 0 !important;
}
.van-popup--center.van-popup--round{
  border-radius: 32px !important;
}
.van-overlay{
  background-color: #00000066 !important;
}
.van-popover__action{
  height: 68px !important;
  width: 188px !important;
  line-height: 56px !important;
  font-size: 28px !important; 
}
.van-toast {
  font-size: 36px !important;
  line-height: 36px !important;
}
.van-tabs__wrap{
  height: 108px !important;
}
.van-tab{
color:"#ffffff66";
font-size: 28px !important;
line-height: 58px !important;
padding: 10px !important;
}
.van-tab--active{
        color: #ffffff;
    }
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
@font-face {
  font-family: DINAlternate-Bold;
  src: url("~@/assets/font/DINPro-Bold.otf");
}
@font-face {
  font-family: PingFang;
  src: url("~@/assets/font/PingFang SC Regular.ttf");
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
.van-notify{
  font-size: 32px !important;
  line-height: 50px !important;
      max-width: 750px;
    transform: translateX(-50%);
    left: 50% !important;
}
.van-list__finished-text{
  font-size: 30px !important;
}
.van-tabs__nav--line{
  padding-bottom: 0 !important;
}
.van-tab{
  margin-right: 60px !important;
}
.jzzs {
  height: 100vh;
}
.jzzs div {
  padding-top: 20%;
  font-size: 23px;
  color: #efcb1b;
}
.van-stepper__input{
  // color: #E6B83A;
  font-size: 36px !important;
}
.van-notice-bar{
  font-size: 26px !important;
  line-height: 100% !important;
}
.van-count-down{
color: #ffffff !important;
font-size: 26px !important;
line-height: 100% !important;
}
@keyframes fadeInUp { from { opacity: 0; transform: translate3d(0, 40px, 0); }
  to { opacity: 1;transform: translate3d(0, 0, 0); } }
.fadeInUp { animation-duration: .8s; animation-name: fadeInUp; }

@keyframes fadeInDow { from { opacity: 0; transform: translate3d(0, -20px, 0); }
  to { opacity: 1;  transform: translate3d(0, 0, 0); } }
.fadeInDow { animation-duration: .8s; animation-name: fadeInDow; }



@keyframes fadeInRight { from { opacity: 0;  transform: translate3d(40px, 0, 0); }
  to { opacity: 1;  transform: translate3d(0, 0, 0); } }
.fadeInRight { animation-duration: .8s; animation-name: fadeInRight; }


@keyframes fadeInLeft { from { opacity: 0;  transform: translate3d(-40px, 0, 0); }
  to { opacity: 1; transform: translate3d(0, 0, 0); } }
.fadeInLeft { animation-duration: .8s; animation-name: fadeInLeft; }

@keyframes fadeScale {from {opacity: 1;transform: scale(1);text-shadow: 0 0  calw(5vw) rgba(white, 1);}to {opacity: 0.8;transform: scale(0.9);text-shadow: 0 0 calw(20vw) rgba(white, 0.5);}	}
	.fadeScale{transform: 0.3;animation: fadeScale .5s infinite alternate;}

   .fadeUpDown{transform: 3;animation: floatUpDownDesktop 5s infinite alternate;}
   @keyframes floatUpDownDesktop {
        0% {
            filter: drop-shadow(0 5px 15px rgba(0, 0, 0, 0.2));
            transform: translate(0%, 0%);
        }
        50% {
            filter: drop-shadow(0 25px 15px rgba(0, 0, 0, 0.2));
            transform: translate(0%, calc(-0% - 20px));
        }
        100% {
            filter: drop-shadow(0 5px 15px rgba(0, 0, 0, 0.2));
            transform: translate(0%, 0%);
        }
    }

    
    .a {
  position: relative;
  color: #16e9f0;
  font-size: 30px;
  letter-spacing: 2px;
  text-transform: uppercase;
  text-decoration: none;
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
  /* to delete length of animation lines: */
  overflow: hidden;
}

    .a:before {
  content: "";
  position: absolute;
  top: 2px;
  left: 2px;
  bottom: 2px;
  width: 100%;
  background: rgba(255, 255, 255, 0.05);
  z-index: -1;
}
 
.a1 {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 2px;
  background: linear-gradient(to right, #035f3c, #f0ec16);
  animation: animate1 2s linear infinite;
  -webkit-animation: animate1 2s linear infinite;
}
 
@keyframes animate1 {
  0% {
    transform: translateX(-100%);
    -webkit-transform: translateX(-100%);
    -moz-transform: translateX(-100%);
    -ms-transform: translateX(-100%);
    -o-transform: translateX(-100%);
  }
  100% {
    transform: translateX(100%);
    -webkit-transform: translateX(100%);
    -moz-transform: translateX(100%);
    -ms-transform: translateX(100%);
    -o-transform: translateX(100%);
  }
}
 
.a2{
  position: absolute;
  top: 0;
  right: 0;
  width: 2px;
  height: 100%;
  background: linear-gradient(to bottom, #5f3703, #f08a16);
  animation: animate2 2s linear infinite;
  -webkit-animation: animate2 2s linear infinite;
  /* add delay to have continuity on effect*/
  animation-delay: 1s;
}
 
@keyframes animate2 {
  0% {
    transform: translateY(-100%);
    -webkit-transform: translateY(-100%);
    -moz-transform: translateY(-100%);
    -ms-transform: translateY(-100%);
    -o-transform: translateY(-100%);
  }
  100% {
    transform: translateY(100%);
    -webkit-transform: translateX(100%);
    -moz-transform: translateX(100%);
    -ms-transform: translateX(100%);
    -o-transform: translateX(100%);
  }
}
 
.a3{
  position: absolute;
  bottom: 0;
  right: 0;
  width: 100%;
  height: 2px;
  background: linear-gradient(to left, #bb0b8f, #f01616);
  animation: animate3 2s linear infinite;
  -webkit-animation: animate3 2s linear infinite;
}
 
@keyframes animate3 {
  0% {
    transform: translateX(100%);
    -webkit-transform: translateX(100%);
    -moz-transform: translateX(100%);
    -ms-transform: translateX(100%);
    -o-transform: translateX(100%);
  }
  100% {
    transform: translateX(-100%);
    -webkit-transform: translateX(-100%);
    -moz-transform: translateX(-100%);
    -ms-transform: translateX(-100%);
    -o-transform: translateX(-100%);
  }
}
 
.a4 {
  position: absolute;
  top: 0;
  left: 0;
  width: 2px;
  height: 100%;
  background: linear-gradient(to top, #1b80df, #0ab7e2);
  animation: animate4 2s linear infinite;
  -webkit-animation: animate4 2s linear infinite;
  /* add delay to have continuity on effect*/
  animation-delay: 1s;
}
 
@keyframes animate4 {
  0% {
    transform: translateY(100%);
    -webkit-transform: translateY(100%);
    -moz-transform: translateY(100%);
    -ms-transform: translateY(100%);
    -o-transform: translateY(100%);
  }
  100% {
    transform: translateY(-100%);
    -webkit-transform: translateY(-100%);
    -moz-transform: translateY(-100%);
    -ms-transform: translateY(-100%);
    -o-transform: translateY(-100%);
  }
}
</style>
