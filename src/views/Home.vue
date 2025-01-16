<template>
  <div class="home">
    <Header />
    <div class="actives fadeInDow">
        <van-swipe class="my-swipe1" :autoplay="6000" :show-indicators="false">
          <van-swipe-item v-for="(item, index) in banner" :key="index">
            <img
              :src="item.thumb"
              alt=""
              class="imgss"
            />
          </van-swipe-item>
        </van-swipe>
      </div>
      <div class="bjcont">
        <div class="item">
          <div class="left">
            <div class="ico">
              <img src="../assets/img/eurs.png" alt="" srcset="" class="img">
            </div>
            <div class="ibox">
              <div class="xname"><div class="name">MLB</div> <div class="names">/USDT</div></div>              
              <div class="lvtxt">24h量(MLB) 800.26万</div>
            </div>
            
          </div>
          <div class="right">
            <div class="price">
              <div class="txt">{{prices}}</div>
              <div class="txs">￥0.0100</div>
            </div>
            <div class="zfcs dang">
              -10.15%
            </div>
          </div>
        </div>
        <div class="item">
          <div class="left">
            <div class="ico">
              <img src="../assets/img/mlc.png" alt="" srcset="" class="img">
            </div>
            <div class="ibox">
              <div class="xname"><div class="name">MLC</div> <div class="names">/USDT</div></div>              
              <div class="lvtxt">24h量(MLC) 2.00万</div>
            </div>
            
          </div>
          <div class="right">
            <div class="price">
              <div class="txt">{{price}}</div>
              <div class="txs">￥55.13</div>
            </div>
            <div class="zfcs">
              +0.21%
            </div>
          </div>
        </div>
        <div class="item">
          <div class="left">
            <div class="ico">
              <img src="../assets/img/btcs.png" alt="" srcset="" class="img">
            </div>
            <div class="ibox">
              <div class="xname"><div class="name">BTC</div> <div class="names">/USDT</div></div>              
              <div class="lvtxt">永续 5,699.99万</div>
            </div>
            
          </div>
          <div class="right">
            <div class="price">
              <div class="txt">96848.3</div>
              <div class="txs">￥709994.79</div>
            </div>
            <div class="zfcs">
              +4.24%
            </div>
          </div>
        </div>
      </div>
      <!-- 关于我们 -->
      <div class="about">
        <div class="top">
          <div class="left">
            <div class="imgs">
              <img src="../assets/img/MLB.png" alt="" srcset="" class="img1">
              <img src="../assets/img/MLBh.png" alt="" srcset="" class="img2">
            </div>
            <div class="txt">产品介绍</div>
          </div>
          <div class="bgimg">
          <img src="../assets/img/11.png" alt="" srcset="" class="img">
        </div>
        </div>
        <div class="cont">
          <div class="txts">A机西是一款国产A创作平台，友好的工具告别复杂操作，支持文生图、虚拟聊天、</div>
            <div class="txts">文案生成等功能。无论你从事什么行业，喜欢什么风格，A机西均可以帮助完成您的需求，</div>
              <div class="txts">免费在线体验强大的AIGC创作能力。</div>
        </div>
        <div class="yqbox">
          <div class="txt">邀请链接</div>
         <div class="linbox">
          <div class="link">{{codeWallet}}</div>
          <button
            type="button"
            class="fuzhi"
            v-clipboard:copy="codeWallet"
            v-clipboard:success="onCopy"
            v-clipboard:error="onError"
          >
          <img src="../assets/img/fuzhi.png" alt="" srcset="" class="img">
          </button>    
         </div>
        </div>       
      </div>
      <!-- 排行榜 -->
      <div class="rank">
        <div class="title">排行榜</div>
        <div class="list">
          <div class="item" v-for="(item,i) in list" :key="i">
            <img src="../assets/img/pm1.png" alt="" srcset="" v-if="i==0" class="pmimg">
            <img src="../assets/img/pm2.png" alt="" srcset="" v-if="i==1" class="pmimg">
            <img src="../assets/img/pm3.png" alt="" srcset="" v-if="i==2" class="pmimg">
            <div class="pm" v-if="i>2">{{i+1}}</div>
            <div class="addr">{{item.rankAddr|yingcang}}</div>
            <div class="amount">{{dexc(item.communityPerformanceU)}}</div>
          </div>
          <div  class="noData" v-if="list.length==0" >
                  <img src="../assets/img/no.png" alt="" >
                  <div class="ttx">暂无数据</div>
                </div>
        </div>
      </div>
      <!-- 合作伙伴 -->
      <div class="business">
        <div class="title">合作伙伴</div>
        <div class="imgbox">
          <img src="../assets/img/b1.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b2.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b3.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b4.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b5.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b6.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b7.png" alt="" srcset=""  class="img">
        </div>
        <div class="imgbox">
          <img src="../assets/img/b8.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b9.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b10.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b11.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b12.png" alt="" srcset=""  class="img">
          <img src="../assets/img/b13.png" alt="" srcset=""  class="img">
        </div>
      </div> 
      <!-- 下载 -->
      <div class="dowload">
        <div class="item">
          <div class="logo">
            <img src="../assets/img/nlo.png" alt="" srcset=""  class="img">
          </div>          
          <div class="name">美林钱包</div>
          <div class="bnt">
            <img src="../assets/img/Vector.png" alt="" srcset=""  class="img">
          </div>
        </div>
        <div class="item">
          <div class="logo">
          <img src="../assets/img/nologo.png" alt="" srcset=""  class="img">
          </div> 
          <div class="name">热比交易所</div>
          <div class="bnt">
            <img src="../assets/img/Vector.png" alt="" srcset=""  class="img">
          </div>
        </div>
        <div class="item">
          <div class="logo">
          <img src="../assets/img/nologo.png" alt="" srcset=""  class="img">
          </div> 
          <div class="name">聊天软件</div>
          <div class="bnt">
            <img src="../assets/img/Vector.png" alt="" srcset=""  class="img">
          </div>
        </div>
        <div class="item">
          <div class="logo">
          <img src="../assets/img/nologo.png" alt="" srcset=""  class="img">
          </div> 
          <div class="name">梯子</div>
          <div class="bnt">
            <img src="../assets/img/Vector.png" alt="" srcset=""  class="img">
          </div>
        </div>
      </div>
      <van-popup v-model="bdshows" round :close-on-click-overlay="!bdshows">
      <div class="popup">
        <div class="ntop">
          <div class="title">绑定上级</div>
        </div>
        <div class="txt">请输入推荐人钱包地址</div>
        <div>
          <input type="text" class="input" v-model="yqmcode" />
        </div>
        <van-button
          :loading="bdloading"
          type="primary"
          @click="tobding"
          class="btn"
          loading-text="绑定中"
        >
          确认绑定</van-button
        >
      </div>
    </van-popup>
       <!-- 授权 -->
       <van-popup v-model="impower" round :close-on-click-overlay="false">
      <div class="popup">
        <div class="sqtxt">要使用您个人账户的功能，请使用钱包授权</div>
        <div class="flsz">
          <van-button
            :loading="sqloading"
            type="primary"
            @click="approve"
            class="btn"
            loading-text="授权中"
          >
           钱包授权</van-button
          >
        </div>
      </div>
    </van-popup>
    <van-popup v-model="shows" round :close-on-click-overlay="false">
      <div class="popup">
        <div class="ntop">
          <div class="title">登录到您的账户</div>
        </div>
        <div class="txt">要使用您个人账户的功能，请点击链接钱包</div>
        <div class="btn" @click="ethConnect">链接钱包</div>
      </div>
    </van-popup>
      <Bottom/>
      </div>
    </template>
    
    <script>
      import Header from "../components/header.vue";
      import Bottom from "../components/sbottom.vue";
      import {
  connectTron,
  Sign,
  getCanBind,
  getUser,
  toBind,
  getRankUsers,
  getPrice,
  getPrices,
  gethasReferrer
} from "@/api/Public";
import { getUserAddress } from "@/api/web3_modal";
import Web3 from 'web3'
    export default {
      name: "Home",
  components: { Header ,Bottom},
  data() {
    return {
      banner: [
        {
          thumb: require("../assets/img/banner.png"),
        },
      ],
      yqmcode:'',
      userInfo:"",
      shows:true,
      bdshows:false,
      bdloading:false,
      impower:false,
      sqloading:false,
      codeWallet: "?code=" + this.$store.getters.userWallet,
      list:[],
      prices:"0.002345",
      price:"7.520482"
    }
  },
  filters:{
    yingcang(val) {
      if (val) {
        let a = val.replace(/(\w{5})\w+(\w{4})/, "$1****$2");       
        return a;
      } else {
        return "...";
      }
    },
  },
  beforeCreate() {
    // var i = 0;
    // var a = setInterval(() => {
    //     getUserAddress().then((info) => {
    //       clearInterval(a);
    //       if (info && info.indexOf("0x") == 0) {
    //         this.shows=false
    //         if (this.$store.getters.myFil != info[0]) {
    //           this.impower=true
    //         } else {
    //           this.userWallet = info[0];
    //           this.$store.commit("userWallet", info[0]);
    //           this.cread(info[0]);
    //         }
    //         //
    //         //
    //       } else {
    //         // this.$notify("请使用BSC地址登录dapp");
    //       }
    //     });
    //   if (i > 5) {
    //     this.shows=true
    //     this.$notify("钱包失联了！！");
    //     clearInterval(a);
    //   }
    //   i++;
    // }, 1000);
  },
  created(){
    this.yqmcode = this.getQueryString("code");
    this.userWallet=this.$store.getters.userWallet  
    let baseUrl=((window.location.href).split("/#/"))[0]
    if(baseUrl.indexOf('?')){
        baseUrl= ((baseUrl).split("/?"))[0]
        this.codeWallet= baseUrl+"?code=" + this.$store.getters.userWallet   
    }else{
       this.codeWallet= baseUrl+"?code=" + this.$store.getters.userWallet
    }
    this.getRank()
    this.getPrice()
   
  },
  mounted() {
    setTimeout(async ()=>{
      const attr = await getUserAddress();      
      if (attr) {
                console.log('获取地址:'+attr)
            this.shows=false
            if (this.$store.getters.myFil != attr) {
              this.$store.commit("userWallet", attr);
              this.impower=true
            } else {
              this.userWallet = attr;
              this.$store.commit("userWallet", attr);
              this.cread(attr);
            }
          }
    },1000)
  },
  methods:{
    ethConnect() {
      getUserAddress().then((info) => {
        console.log(info);
        if (info) {
          this.shows = false;
          this.cread(info);
          this.$store.commit("userWallet", info);
        } else {
          this.$notify("请使用钱包地址登录");
        }
      }).catch(err=>{
        this.$notify(err);
      });
    },
    getPrice(){
      getPrice().then(res=>{
                this.price=res
            })
            getPrices().then(res=>{
                this.prices=res
            })
    },
    dexc(val){
        if(val){
        let  ethereum = window.ethereum
        let web3s = new Web3(ethereum);
        let amount=  web3s.utils.fromWei(val +'', 'ether'); 
        // let num =val/Math.pow(10,18)
        return val?  Math.round(amount*1000000)/1000000:'0'
        }else{
        return 0
        }
        },
    getRank(){
      getRankUsers().then(res=>{
        this.list= res.map(el=>{
          el=Object.assign({},el)
          return el
        })
      })
    },
    approve() {
      this.userWallet=this.$store.getters.userWallet 
      if (this.userWallet) {
        this.sqloading = true;
        // Sign(this.userWallet).then((rs) => {
          this.sqloading = false;
          // if (rs) {
            this.impower = false;
            this.$store.commit("myFil", this.userWallet);
            this.cread(this.userWallet);
            this.$store.commit("userWallet", this.userWallet);
          // }
        // });
      }
    },
    getpice(){
      fetch("https://114.111.61.67/swap/v1/portal/public/list?lang=zh_CN&platform=4&client=4&deviceId=H_FmghYko5Zi688yy01Nlq&versionCode=3.1.1",{
        method:"POST",        
      headers: {
        'Content-Type': 'application/json'
      },
      }).then(errs=>{

      })
      let formData =new FormData()
      formData .append('shortName','MLC')
      formData .append('platform','1')
      formData .append('client','1')
      formData .append('deviceId','P_FmghYko5Zi688yy01Nlq')
      formData .append('versionCode','3.2.0')
      formData .append('deviceModel','Chrome 131.0.0.0 (Windows)')
      formData .append('lang','en_US')     
      console.log(data);
      fetch("https://bin.spentr.com/hk-web/v2/coin_info",{
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    }).then(res=>{

      })
    },

    cread(val) {
      this.userWallet = this.$store.getters.userWallet || val;    
      if (this.userWallet) {
        let baseUrl = window.location.href.split("/#/")[0];
        if (baseUrl.indexOf("?")) {
          baseUrl = baseUrl.split("/?")[0];
          this.codeWallet = baseUrl + "?code=" + this.$store.getters.userWallet;
        } else {
          this.codeWallet = baseUrl + "?code=" + this.$store.getters.userWallet;
        }
        gethasReferrer(this.userWallet).then(res=>{
          console.log(res);
          this.bdshows = !res;
        })
        getUser(this.userWallet).then((res) => {
          console.log(res,'userInfo');
          this.userInfo = Object.assign({}, res);
          // if (res.referrer == "0x0000000000000000000000000000000000000000") {
          //   this.bdshows = true;
          // }
        });
      } else {
        this.shows = true;
      }
    },
    tobding() {
      if (this.yqmcode) {
        if (this.bdloading) {
          this.$toast("绑定中...");
          return;
        } else {
          getCanBind(this.yqmcode).then((res) => {
            console.log(res);
            if (res) {
              this.bdloading = true;
              this.bangding(this.yqmcode);
            }else{
              this.$toast("您的邀请地址不符合邀请需求！");
            }
          });
        }
      } else {
        this.$toast("请输入推荐人钱包地址");
      }
    },
    async bangding(code) {
      if (code) {
        if (code == this.userWallet) {
          return;
        }
        toBind(this.userWallet, code).then((res) => {
          this.bdloading = false;
          if (res) {
            this.$notify({message:"绑定成功",type: "success",});  
            this.bdshows = false;
          }
          //console.log(res);
        });
      } else {
        this.bdloading = false;
      }
    },
    getQueryString(name) {
      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
      var r = window.location.search.substr(1).match(reg);
      if (r != null) return unescape(r[2]);
      return null;
    },
    onCopy() {
      this.$notify({message:"复制成功",type: "success",});   
    },
    onError() {
      this.$toast("复制失败");
    },

  }
    }
    </script>
    
<style lang="scss" scoped>
      .home{
        background: #010101;
  background-size: contain;
  background-position: center bottom;
  overflow-x: hidden;
  width: 750px;
  margin: 0 auto;
  min-height: 100vh;
  .actives {
      width: calc(100%);
      margin: 120px auto 0;
      .my-swipe1 {
        width: calc(100% - 20px);
        height: 100%;
        margin: 10px auto 0;
        // padding: 10px;
        .imgss {
          width: calc(100% - 42px);
          height: auto;
          //  border:2px solid #3bf7ff;
          border-radius: 16px;
          box-shadow: 0 1px 1px rgb(0 0 0 / 12%), 0 2px 2px rgb(0 0 0 / 12%),
            0 4px 4px rgb(0 0 0 / 12%), 0 8px 8px rgb(0 0 0 / 12%),
            0 16px 16px rgb(0 0 0 / 12%);
        }
      }
    }
    .bjcont{
      margin-top: 60px;
      background: linear-gradient(180deg, #111111 24.52%, rgba(0, 0, 0, 0) 88.56%);
      padding: 30px 0;
      .item{
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding:20px 30px;
        .left{
           display: flex;
        align-items: center;
          .ico{
            margin-right: 20px;
            .img{
              width: 48px;
              height: 48px;
            }
          }
          .ibox{
            .xname{
              display: flex;
              align-items: center;
              .name{
                font-size: 28px;
                color: #ffffff;
                margin-right: 5px;
              }
              .names{
                font-size: 22px;
                color: #909090;
              }
            }
            .lvtxt{
              font-size: 20px;
              color: #909090;
            }
          }
        }
        .right{
          display: flex;
          align-items: center;
          .price{
            .txt{
              font-size: 28px;
                color: #ffffff;
            }
            .txs{
              font-size: 20px;
              color: #909090;
            }
          }
          .zfcs{
            margin-left: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 150px;
            height: 62px;
            border-radius: 4px;
            background: #01B494;
            color: #ffffff;
            font-size: 28px;
          }
          .dang{
            background: #f34a68;
          }
        }
      }
    }

.about{
  border-top: 1px solid #ffffff24;
  padding-top: 86px;
  margin-top: 20px;
  .top{ display: flex;
      align-items: center;
      justify-content: space-between;
    .left{
      display: flex;
      align-items: flex-start;
      flex-direction: column;
      margin-left: 64px;
      .imgs{
        position: relative;
        height: 100px;
        width: 280px;
        .img1{
          position: absolute;
          left: 12px;
          top: 0;
          width: 280px;
          height: 100px;
        }
        .img2{
          position: absolute;
          left: 0;
          top: 12px;
          width: 280px;
          height: 100px;

        }
      }
      .txt{
        font-size: 28px;
        color: #ffffff;
        position: relative;
        margin-top: 24px;
      }
      .txt::after{
        content: "";
        position: absolute;
        width: 20px;
        height: 10px;
        bottom: 0;
        left: 0;
        background:  #2B60F3;
      }
    }

    .bgimg{
      width: 392px;
      .img{
        width: 392px;
      }
    }
  }
  .cont{
    padding: 32px;
    .txts{
      font-size: 26px;
      color: #9a9a9a;
      text-align: left;
    }
  }
  .yqbox{
    padding: 30px;
    .txt{
      font-family: DingTalk JinBuTi;
      font-size: 32px;
      font-style: italic;
      font-weight: 400;
      line-height: 28px;
      text-align: left;
      color: #ffffff;
    }
    .linbox{
      width: 100%;
      height: 88px;
      background: #081028;
      border: 1px solid #2B60F3;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 32px;
      box-sizing: border-box;
      margin-top: 22px;
      border-radius: 8px;
      .link{
        font-size: 28px;
        color: #ffffff;
        white-space: nowrap;
        width: 80%;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      .fuzhi {
        background: transparent;
        border: none;
        .img{
          width: 22px;
          height: 22px;
        }
      } 
    }
  }
 
}
.rank{
  background: linear-gradient(180deg, #111111 24.52%, rgba(0, 0, 0, 0) 88.56%);
  height: 744px;
  overflow-y: auto;
    .title{
      font-size: 32px;
      font-style: italic;
      color: #ffffff;
      text-align: center;
      padding-top: 40px;
    }
    .list{
      padding: 30px;
      .item{
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 80px;
        .pm{
          font-size: 28px;
          font-weight: bold;
          color: #ffffff;
          width: 48px;
          text-align: center;
        }
        .pmimg{
          width: 48px;
        }
        .addr{
          color: #ffffff;
          font-size: 28px;          
        }
        .amount{
          font-size: 32px;
          color: #ffffff;
          font-style: italic;
        }
      }
    }
  }
  .business{
    height: 326px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    .title{
      font-size: 32px;
      font-style: italic;
      color: #ffffff;
      text-align: center;
      padding-top: 40px;
    }
    .imgbox{
      display: flex;
      align-items: center;
      justify-content: center;
      flex-wrap: nowrap;
      .img{
        width: 52px;
        height: 52px;
        margin: 14px 20px;
      }
    }
  }
  .dowload{
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 30px;
    box-sizing: border-box;
    margin-top: 70px;
    margin-bottom: 200px;
    .item{
      display: flex;
      align-items: center;
      flex-direction: column;
      border-radius: 24px 24px 0 0;
      background: linear-gradient(180deg, #191919 0%, rgba(0, 0, 0, 0) 100%);
      width: 23%;
      height: 218px;
      .logo{
        height: 64px;
      }
      .img{
        width: 64px;
        height: auto;
        margin-top: 24px;
      }
      .name{
        color: #264496;
        font-size: 20px;
        margin-top: 40px;
      }
      .bnt{
        margin-top: 16px;
        .img{
          width: 24px;
          height: 26px;
          cursor: pointer;
        }
      }
    }
  }

  .noData{
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: column;
		justify-content: center;
    min-height: 20vh;
		img{
			width: 242px;
			margin: 50px auto 20px;
		}
     .ttx{
      font-size:24px;
      color: #ffffff !important;
   font-weight: bold;
   margin: 20px auto 20px;
    }
	}
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
      }
    </style>