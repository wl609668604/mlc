<template>
<div class="">
    <div class="top">
        
        <div class="logo fadeInLeft">   
       <div class="slogo " > 
         <div class="slo">
         <img src="../assets/img/logo.png" alt=""  class="img2" />
         </div>
         </div> 
         <div class="navbtn fadeInRight" @click="ethConnect">
          <span>{{this.$store.getters.userWallet?this.$store.getters.userWallet :'Connect' |yingcang}}</span>
        </div>      
        </div>
        <div class="flexright">
         
        <div class="lang">
    <div class="bbox">
              
          <img src="../assets/img/news.png" alt="" class="limg">    
        </div> 
        </div>
          <div class="icosn">
       <img src="../assets/img/kf.png" alt="" class="img" />      
       </div></div>
      </div>
    </div>
</template>

<script>
import { connectTron} from "@/api/Public";
import { getUserAddress } from "@/api/web3_modal";
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  computed: {
    dqyy() {
      if (this.$store.getters.language) {
        return this.$store.getters.language;
      } else {
        return "en-US";
      }
    },
  },
  data(){
    return{
      userWallet:'',
      clmenuShows:false,
      show:false,
      active:"/",
      lang:{},
      langs:[
       
        {
          icon: require('../assets/img/en.png'),
          text:"Englist",
          value:'en-US'
        },
        // {
        //   icon: require('../assets/img/ka.png'),
        //   text:"한국어",
        //   value:'ko'
        // },
        // {
        //   icon: require('../assets/img/ja.png'),
        //   text:"日本語",
        //   value:'ja'
        // },
        // {
        //   icon: require('../assets/img/xby.png'),
        //   text:"español",
        //   value:'xby'
        // },
        {
          icon: require('../assets/img/cny.png'),
          text:"中文繁体",
          value:'zh-CN'
        },
      ]
    }
  },
  filters:{
    yingcang(val) {
      if (val) {
        let a = val.replace(/(\w{7})\w+(\w{4})/, "$1...$2");       
        return a;
      } else {
        return "...";
      }
    },
  },
  created(){
    // this.ethConnect()
    this.langInit()
    this.userWallet = this.$store.getters.userWallet;  
  },
  methods:{
    ethConnect() {
      getUserAddress().then((info) => {
        if (info) {  
          this.userWallet=info 
          this.$store.commit("userWallet", info);      
        } else {
          this.$toast("请使用钱包地址登录");
        }
      }).catch(err=>{
        this.$notify(err);
      });
    },
    onSelect(item) {
      this.lang=item
      let val=item.value
      this.$i18n.locale = val;
      this.$store.commit("language", val);
      this.show=false
    },
    langInit(){
      this.langs.map(el=>{
      if(el.value==this.$store.getters.language){
        this.lang=el
      }
    })
    },
    menuopen() {
   
    this.active=this.$route.path;
      this.clmenuShows = true;
    },
    gbsmenu(e) {
      if (e == this.active) {
        return;
      }
      this.clmenuShows = false;      
      if(e){
      this.handleFiexdToolItem(e)
      }
    },
    to(url) {
       window.open(url)
    },
   
    handleFiexdToolItem(e){
    // this.$notify(this.$i18n.t("m.wxtszwkf"))
    // return
  this.$router.push({path:e})
},
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
$t-mf: "PingFang";
$t-f: "DINAlternate-Bold";
.top {
    // height: 156px;
    // @include background_color("background_color1");
    
    position: fixed;
    top: 0;
    z-index: 99;
    
background: #262626;
      // background: url("../assets/img/tbg.png")  no-repeat;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 14px 15px;
    width: calc(100%);
    max-width: 750px;
    margin: 0 auto;
    color: #fff;
    box-sizing: border-box;
    .logo {
      display: flex;
      align-items: center;    
      margin-left: 15px;
      .slogo{
display: flex;
align-items: center;
      .slo{
// background: linear-gradient(
// 128deg
// ,#ffdf2d,#00e2be);
// background: linear-gradient(
// 128deg
// ,#e7efcd,#00e2be);
// box-shadow: 0px 4px 16px 4px #00e2be;
// border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
      }

.ttt{
font-size: 32px;
font-family:$t-f;
font-weight: 600;
color: #FFFFFF;
margin-left: 10px;
}
        .img2{
          width: auto;
          height: 48px;
          
      border-radius: 100%;
          // margin-left: -50px;
          // border-radius: 6px;
        }
      }
    }
    
     .title{
      color: #fff;
      font-size: 36px;
      font-family: $t-mf;
    }
    .navbtn {
      display: flex;
      justify-content: center;
      align-items: center;
     min-width: 170px;
     padding: 0 40px;
height: 60px;
border-radius: 100px;
margin-right: 16px;
//  border: 1px solid #735f24;
// background: linear-gradient(188.1deg, rgb(175, 57, 239) 18.52%, rgb(139, 61, 206) 71.67%);
// background: url('../assets/img/bm/b1.png') no-repeat;
background-size: 100% 100%;
font-family: $t-mf;

// background: linear-gradient(
// 128deg
// ,#ffdf2d,#00e2be);
// box-shadow: 0px 4px 16px 4px rgba(62,1,162,1);
// border-radius: 30px;
font-size: 28px;
font-weight: 600;
color: #FFFFFF;
  
    }
      .icosn {
        margin-right: 15px;
       width: 42px;
height: 42px;
// border-radius: 16px;
display: flex;
align-items: center;
justify-content: center;
        .img{
          width: 42px;
        }
      }
      .flexright{
        display: flex;
        align-items: center;
            .lang {
              display: flex;
              align-items: center;
              justify-content: center;
              width: 42px;
            height: 42px;
        margin-right: 16px;
        .bbox{display: flex;}
        .limg{
        height: 100%;
        width: 100%;
        border-radius: 100%;
        padding: 1px;
        box-sizing: border-box;
      }
      }
      }
  }

  .sfelx{
 display: flex;
    flex-direction: column;
    height: 100%;
    border-left: 1px solid #735f24;
    background:  #262626 no-repeat;
        //  background-size:contain;
         background-position: center top;
  }

  .mentop {
    display: flex;
    align-items: center;
    margin: 44px 30px;
    position: relative;
    flex-direction: column;
justify-content: center;
    .slogs{
      //  width: 56px;
// height: 56px;
margin: 44px 30px;
// background: linear-gradient(
// 128deg
// ,#e7efcd,#00e2be);
display: flex;
align-items: center;
justify-content: center;
border-radius: 100%;
   .logo {
      height: 128px;
    }
  
    }
    .tix{
      font-size: 32px;
font-family: $t-f;
font-weight: 600;
color: #FFFFFF;
line-height: 44px;
    }
    .close{
      position: absolute;
      right: 0;
      top: 0px;
      width: 56px;
      height: 56px;
    }
  }
  .menulist {
    margin-top: 30px;
    .menuitem {
            display: flex;
      align-items: center;      
    justify-content: space-between;
      margin: 20px 24px 20px 44px;
      padding: 20px;
      border: 1px solid #dcbd77;
    border-radius: 0;
    background: linear-gradient(95.46deg, #484848, #070708);
      .left {
        margin-right: 12px;
        text-align: left;
        display: flex;
        img {
          height: 44px;
          width: 44px;
        }
        .txt {
          margin-left: 30px;
          font-family: $t-mf;
          // font-weight: 600;
          font-size: 28px;
          color: #f4e1b3;
          opacity: 0.5;
          line-height: 50px;
        }
      }
      .right {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        img{
          width: 26px;
          height: 26px;
        }
      }
    }
    .act{
       .txt {
         opacity: 1 !important;
       }
    }
  }
  .foot{
        display: flex;
    flex-direction: column;
    flex: 1;
    justify-content: center;
    padding: 40px;
    .lang{
      display: flex;
      align-items: center;      
    justify-content: center;
    border: 1px solid #735f24;
    width: 340px;
    height: 68px;
    border-radius: 18px;
    margin: 10px auto 40px;
    .bbox{
      display: flex;
      align-items: center;      
    justify-content: center;
    }
      .limg{
        height: 40px;
        width: 40px;
        border-radius: 100%;
      }
      .ttl{
        font-size: 24px;
font-family: $t-f;
font-weight: 600;
color: #FFFFFF;
line-height: 34px;
margin-left: 10px;
margin-right: 10px;
      }
      .dwimg{
        width: 32px;
        margin-left: 10px;
      }
    }
    .btn{
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 100px;
          height: 68px;
          width: 100%;
          font-size: 24px;
      color: #ffffff;
          background: linear-gradient(188.1deg, rgb(175, 57, 239) 18.52%, rgb(139, 61, 206) 71.67%);
    }
    .price{
      font-size: 24px;
font-family:$t-f;
font-weight: 600;
color: #FFFFFF;
line-height: 34px;
margin: 18px 0;
text-align: left;
.num{
  margin-left: 20px;
  font-family: $t-mf;
}
    }
    .imgline{
      display: flex;
      align-items: center;
    }
    .slog{
      height: 44px;
      width: 44px;
      margin: 20px;
    }
  }
  .purp{
    position: absolute;
    left: 50%;
    border: 1px solid #20202080;
    transform: translateX(-50%);
    top: 122px;
    background: linear-gradient(135.46deg, rgba(6, 6, 6, 0.5) 24.8%, rgba(32, 32, 32, 0.5) 57.07%);
    padding: 15px 20px;
    inset: 0px auto auto 50%;
    transform: translate3d(-50%, 800px, 0px);
    z-index: 9999;
    .linex{
      display: flex;
      align-items: center;
      margin: 16px;
      .limg{
        width: 40px;
        height: 40px;
        border-radius: 100%;
      }      
      .txt{
        margin-left: 20px;
        font-size: 24px;
        color: #FFFFFF;
      }
    }
  }
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
