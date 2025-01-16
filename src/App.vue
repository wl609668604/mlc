<template>
  <div id="app">
    <transition name="slide-fade" mode="out-in">
      <router-view v-if="shows" />
    </transition>

    <!-- 绑定弹窗 -->
    <van-popup v-model="showBinding" round :close-on-click-overlay="!showBinding">
      <div class="popup">
        <div class="ntop">
          <div class="title">绑定上级</div>
        </div>
        <div class="txt">请输入推荐人钱包地址</div>
        <div>
          <input type="text" class="input" v-model="attr" />
        </div>
        <van-button
          :loading="isLoading"
          type="primary"
          @click="bindSubmit"
          class="btn"
          loading-text="绑定中"
        >
          确认绑定</van-button
        >
      </div>
    </van-popup>
  </div>
</template>

<script>
import { getAddress,hasReferrer,canBind } from "@/api/contract";
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
      showBinding: false,
      isLoading: false,
      attr: ''
    };
  },

  
  async mounted() {
    setInterval(async () => {
      const attr = await getAddress();
      alert('钱包地址:'+attr)
      console.log('钱包地址',attr)
      this.$store.commit("updateAddress", attr);

      // 判断是否已经绑定
      const isBing =  await hasReferrer();
      this.showBinding = !isBing;
      console.log('是否已经绑定',isBing)
    }, 2000);

  },
  methods: {
    // 绑定上级
    async bindSubmit() {
      if (!this.attr) return this.$notify("请输入用户地址");;
      try {
        await canBind(this.attr);
        // 绑定成功
        this.$notify("绑定成功！");
      } catch (error) {
        console.log(error)
        this.$notify("绑定失败！");
      }
    },
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
// 弹框UI
.popup {
    width: 672px;
    background: #ffffff;
    // border-radius: 30px;
    padding: 30px 30px 40px;
    box-sizing: border-box;
    ::v-deep.van-list {
      height: 50vh;
      overflow: auto;
    }
    ::v-deep .van-stepper__input {
      font-size: 42px;
    }

    .tips {
      font-size: 28px;
      font-weight: 600;
      color: #999999;
      line-height: 66px;
      margin: 24px auto;
    }
    .inode {
      display: flex;
      justify-content: space-between;
      flex-direction: column;
      align-items: center;
      background: #f1f1f1;
      // border-radius: 8px;
      margin: 8px 34px;
      padding: 20px 8px;
      font-weight: 400;
      font-size: 28px;
      .items {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        .line {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin: 10px;
          flex: 1;
          .left {
            text-align: left;
            font-size: 22px;
            font-weight: 400;
            color: #999;
            line-height: 32px;
          }
          .right {
            font-size: 22px;
            font-weight: 600;
            color: #131415;
            line-height: 32px;
          }
        }
      }
      .fuzhi {
        background: transparent;
        border: none;
        color: #1755ee;
      }
    }
    .input {
      border: none;
      width: 100%;
      height: 68px;
      background: #f8f8f8;
      // border-radius: 50px;
      margin: 10px auto;
      padding: 10px 20px;
      font-size: 28px;
      box-sizing: border-box;
      // background: transparent;
      border-radius: 16px;
    }
    .balance{
      font-size: 28px;
      font-weight: 400;
      line-height: 40px;
      text-align: right;
    }
    .tl{
      text-align: left;
      margin: 16px 20px;
    }
    .icon{
      width: 68px;
      margin: 16px auto;
    }
    .bg {
      background: linear-gradient(234deg, #e4005e, #b4184c);
      margin: 20px 34px;
      padding: 10px;

      // border-radius: 20px;
    }
    .logo {
      // height:188px;
      width: 188px;
      margin: 44px auto 20px;
    }
    .item {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #262626;
      //  border-radius: 10px;
      padding: 0 10px;
      .txts {
        font-size: 32px;
        text-align: right;
        margin: 10px 0;
        font-weight: bold;
        line-height: 54px;
        background: linear-gradient(234deg, #e4005e, #b4184c);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
      .flexs {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        padding: 10px 0;

        .tts {
          font-size: 28px;
          font-weight: 600;
          line-height: 40px;
          text-align: left;
          margin: 0 10px;
        }
      }
      .txd {
        margin: 20px 0;
        text-align: left;
        font-size: 24px;
        font-weight: 600;
        color: #f8f8f8;
        line-height: 40px;
      }
      .inputs {
        border: none;
        height: 50px;
        width: 100%;
        font-size: 34px;
      }
    }
    .txt {
      font-size: 28px;
      font-weight: 400;
      line-height: 40px;
      margin: 10px 0;
    text-align: left;
    width: 100%;
    }
    .ntop {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 32px;
      .close {
        width: 28px;
      }
      .title {
        width: 100%;
        font-size: 32px;
        font-weight: bold;
        color: #000000;
        text-align: left;
      }
    }
    .sqtxts {
      font-size: 24px;
      font-weight: 600;
      color: #848484;
      line-height: 44px;
      margin: 10px 0 45px;
      padding: 0 22px;
      box-sizing: border-box;
      text-align: left;
    }
    .sqtxt {
      font-size: 32px;
      font-weight: 600;
      color: #848484;
      line-height: 44px;
      margin: 10px 0 45px;
      padding: 0 22px;
      box-sizing: border-box;
    }
    .xbox {
      background: #f3f0f4;
      padding: 10px 20px;
      border-radius: 36px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin: 16px auto;
      .num {
        //  margin: 22px auto;
        font-size: 24px;
        font-weight: bold;
        background: linear-gradient(34deg, #1fa391, #28514b);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
      .txt {
        color: #2a2a2a;
        font-size: 24px;
        font-weight: bold;
        margin: 0 10px;
      }
    }
    .rbox {
      display: flex;
      align-items: center;
      justify-content: center;

      .num {
        //  margin: 22px auto;
        font-size: 42px;
        font-weight: bold;
        background: linear-gradient(
          100deg,
          #d5b275 0%,
          #e6d69a 31%,
          #d9ad2a 49%,
          #c5a26c 79%,
          #a58b00 100%
        );
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
      .txt {
        color: #2a2a2a;
        font-size: 24px;
        font-weight: bold;
        margin: 0 10px;
      }
      .ico {
        width: 40px;
        height: 40px;
      }
    }
    .flsz {
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    .cnet {
      text-align: center;
      font-size: 46px;
    }
    .btn {
      width: calc(100% - 200px);
      height: 80px;
      font-size: 32px;
      font-weight: 600;
      color: #ffffff;
      line-height: 80px;
      margin: 34px auto 22px;
      background: #2B60F3;
      border-radius: 40px;
      border: none;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .btns {
      width: 480px;
      height: 80px;
      font-size: 32px;
      font-weight: 600;
      color: #ffffff;
      line-height: 80px;
      margin: 54px auto;
      background: linear-gradient(
        90deg,
        #f83afd 0%,
        #c333ff 31%,
        #a84bff 49%,
        #724eff 79%,
        #495afa 100%
      );
      box-shadow: 0px 4px 16px 4px rgba(207, 182, 247, 1);
      // border-radius: 40px;
      border: none;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .nbtn {
      width: 100%;
      height: 80px;
      box-shadow: 0px 4px 16px 4px rgba(227, 211, 253, 1);
      // border-radius: 40px;
      border: 2px solid rgba(115, 40, 236, 0.5);
      font-size: 32px;
      margin: 54px 20px;
      font-weight: 600;
      color: #b4184c;
      line-height: 44px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .lang {
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 50px auto;
      img {
        height: 50px;
        width: 50px;
      }
      span {
        font-size: 28px;
        font-weight: 400;
        line-height: 40px;
      }
    }
  }

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
