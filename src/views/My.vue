<template>
  <div class="home">
    <div class="title">我</div>
    <div class="mtop">
      <img src="../assets/img/mybg.png" alt="" srcset="" class="bg">
      <div class="left">
        <div class="ittx">
        <div class="amount">{{dexc(userInfo.runInvestment)}} <span class="dw">MLC</span></div>
        <div class="txt">我的托管</div>
      </div>
      <div class="ittx">
        <div class="amount">{{dexc(userInfo.communityPerformanceU)}} <span class="dw">USDT</span></div>
        <div class="txt">团队业绩</div>
      </div>
      </div>
      <div class="right">
        <img src="../assets/img/lv1.png" alt="" srcset="" class="img" v-if="userInfo.userLevel==1">
        <img src="../assets/img/lv2.png" alt="" srcset="" class="img" v-if="userInfo.userLevel==2">
        <img src="../assets/img/lv3.png" alt="" srcset="" class="img" v-if="userInfo.userLevel==3">
        <img src="../assets/img/lv4.png" alt="" srcset="" class="img" v-if="userInfo.userLevel==4">
        <img src="../assets/img/lv5.png" alt="" srcset="" class="img" v-if="userInfo.userLevel==5">

      </div>
    </div>
    <div class="mybox">
      <div class="item">
        <div class="left">我的钱包地址</div>
        <div class="right">
          <div class="addr">{{userWallet}}</div>
          <button
            type="button"
            class="fuzhi"
            v-clipboard:copy="userWallet"
            v-clipboard:success="onCopy"
            v-clipboard:error="onError"
          >
          <img src="../assets/img/ico_hfz.png" alt="" srcset="" class="img">
          </button>  
        </div>
      </div>
      <div class="item">
        <div class="left">我的邀请人</div>
        <div class="right">
          <div class="addr">{{yqWallet}}</div>
          <button
            type="button"
            class="fuzhi"
            v-clipboard:copy="yqWallet"
            v-clipboard:success="onCopy"
            v-clipboard:error="onError"
          >
          <img src="../assets/img/ico_hfz.png" alt="" srcset="" class="img">
          </button>  
        </div>
      </div>
      <div class="item">
        <div class="left">邀请链接</div>
        <div class="right">
          <div class="addr">{{codeWallet}}</div>
          <button
            type="button"
            class="fuzhi"
            v-clipboard:copy="codeWallet"
            v-clipboard:success="onCopy"
            v-clipboard:error="onError"
          >
          <img src="../assets/img/ico_hfz.png" alt="" srcset="" class="img">
          </button>  
        </div>
      </div>
      <div class="item">
        <div class="left">我的团队直推列表</div>
        <div class="btn" @click="toPage('/Direct')">
          <img src="../assets/img/ico_lr.png" alt="" srcset="" class="img">
        </div>
      </div>
      <!-- <div class="item">
        <div class="left">我的直推业绩</div>
        <div class="btn" @click="toPage('/Directs')">
          <img src="../assets/img/ico_lr.png" alt="" srcset="" class="img">
        </div>
      </div> -->
    </div>
    <div class="tringbox">
                <div class="sitem">
                    <div class="trop">
                        <div class="name">静态收益</div>
                    </div>
                    <div class="nbox">
                        <div class="left">
                            <div class="ico">
                                <img src="../assets/img/ico_mlc.png" alt="" srcset=""  class="img">
                            </div>
                            <div class="sprice">{{userInfo.staticAmount||0}} / MLC</div>
                        </div>
                        <div class="right" @click="toHzshow(1)">
                            <img src="../assets/img/ico_lq.png" alt="" srcset=""  class="img">
                            <div class="txt">领取</div>
                        </div>
                    </div>
                </div>
                <div class="line"></div>
                <div class="sitem">
                    <div class="trop">
                        <div class="name">动态收益</div>
                    </div>
                    <div class="nbox">
                        <div class="left">
                            <div class="ico">
                                <img src="../assets/img/ico_mlc.png" alt="" srcset=""  class="img">
                            </div>
                            <div class="sprice">{{userInfo.dynamicAmount||0}} / MLC</div>
                        </div>
                        <div class="right" @click="toHzshow(2)">
                            <img src="../assets/img/ico_lq.png" alt="" srcset=""  class="img">
                            <div class="txt" >领取</div>
                        </div>
                    </div>
                </div>
            </div>
    <div class="tablist">
            <div class="tabs">
                <div class="nav " :class="cur==0?'act':''" @click="toChange(0)">静态收益明细</div>
                <div class="nav" :class="cur==1?'act':''" @click="toChange(1)">团队收益明细</div>
            </div>
            <van-pull-refresh v-model="refreshing" @refresh="onRefresh" loosing-text="loading">
          <van-list
            v-model="loading"
            :finished="finished"
             loading-text="loading"
            finished-text=""
            @load="onLoad"            
          >
            <div class="list">
              <div class="sheader">
                <div class="txt">时间</div>
                <div class="txt">数量</div>
              </div>
              <div class="item" v-for="(item,i) in list" :key="i">
                <div class="txts">{{formatDate(item.timestamp)}}</div>   
                <div class="txts">{{dexc(item.amount)}}/MLC</div>
              </div>         
              <div  class="noData" v-if="list.length==0" >
                  <img src="../assets/img/no.png" alt="" >
                  <div class="ttx">暂无数据</div>
                </div>
            </div>
          </van-list>
        </van-pull-refresh>
        </div>
     
        <van-popup v-model="lqshow" round :close-on-click-overlay="false">
      <div class="popup">
        <div class="top">
          <div class="title">领取确认</div>
          <img
            src="../assets/img/gbs.png"
            alt=""
            class="close"
            v-if="!lqloading"
            @click="lqshow = false"
          />
        </div>
        <div class="sqtxt"> 您有</div>
        <div class="rbox">
          <div class="num">{{ lqNum || 0 }}</div>
          <div class="txt" >MLC</div>
          <img
            src="../assets/img/slogo.png"
            alt=""
            v-if="lqType == 3"
            srcset=""
            class="ico"
          />         
        </div>
        <div class="sqtxt" v-if="staticAmountMlb>0&&lqType==1"> 您需要支付{{staticAmountMlb}} MLB</div>
        <div class="sqtxt" v-if="dynamicAmountMlb>0&&lqType==2"> 您需要支付{{dynamicAmountMlb}} MLB</div>
        <div class="flsz">
          <van-button
            :loading="lqloading"
            type="primary"
            @click="scSelect"
            class="btn"
          >
            确定领取</van-button
          >
        </div>
      </div>
    </van-popup>
      <Bottom/>
      </div>
    </template>
    
    <script>
      import Bottom from "../components/sbottom.vue";
      import {getUser,gethasReferrer,getHistoryStatic,getHistoryDynamic,toWithdrawal,toWithdrawalDynamic,toApproves,getUserExtras} from "@/api/Public";
      import Web3 from 'web3'
    export default {
      name: "Home",
  components: { Bottom},
  data() {
    return {
      userWallet:"",
      codeWallet: "?code=" + this.$store.getters.userWallet,
      yqWallet:"",
      cur:0,
      userInfo:"",
      loading: false,
        finished: false,
        refreshing: false,
        page:1,
        size:10,
        list:[],
        lqshow:false,
        lqloading:false,
        lqNum:'',
        lqType:1,
        staticAmountMlb:0,
        dynamicAmountMlb:0,
  
    }
  },
  created(){
    this.userWallet=this.$store.getters.userWallet  
    let baseUrl=((window.location.href).split("/#/"))[0]
    if(baseUrl.indexOf('?')){
        baseUrl= ((baseUrl).split("/?"))[0]
        this.codeWallet= baseUrl+"?code=" + this.$store.getters.userWallet   
    }else{
       this.codeWallet= baseUrl+"?code=" + this.$store.getters.userWallet
    } 
    this.getUser()
  },
  methods:{
    scSelect(){
      if(this.lqNum==0){return}
      if(!this.$store.getters.userWallet){return}  
      this.lqloading=true
      if(this.lqType==1){
        this.toWithdrawal()
      }else{
        this.toWithdrawalDynamic()
      }
    },
    toHzshow(e){
      if(!this.$store.getters.userWallet){return}  
      getUserExtras(this.$store.getters.userWallet).then(res=>{
        console.log(res,'Extras');
          this.staticAmountMlb=this.dexc(res.staticAmountMlb)
          this.dynamicAmountMlb=this.dexc(res.dynamicAmountMlb)
          this.lqType=e
          this.lqNum=e==1?this.userInfo.staticAmount:this.userInfo.dynamicAmount
          this.lqshow=true
        })      
      },
    toWithdrawalDynamic(){
      if(!this.$store.getters.userWallet){return}  

      toWithdrawalDynamic(this.$store.getters.userWallet ).then(res=>{
        this.lqloading=false
        if(res){
          this.$notify({message:"提现成功",type: "success",});  
          this.lqshow=false
          this.getUser() 
        }else{
          this.$notify("提现失败")
        }
      })
    },
    toWithdrawal(){
      if(!this.$store.getters.userWallet){return}  
      toWithdrawal(this.$store.getters.userWallet ).then(res=>{
        this.lqloading=false
        if(res){
          this.$notify({message:"提现成功",type: "success",});   
          this.lqshow=false
          this.getUser() 
        }else{
          this.$notify("提现失败")
        }
      })
    },
    formatDate(e) {
      if (e == 0) {
        return "";
      } else {
        let date = new Date(e * 1000);
        let Y = date.getFullYear();
        let M = date.getMonth() + 1;
        let D = date.getDate();
        let h = date.getHours();
        let m = date.getMinutes();
        let s = date.getSeconds();
        if (M < 10) {
          M = "0" + M;
        }
        if (D < 10) {
          D = "0" + D;
        }
        if (h < 10) {
          h = "0" + h;
        }
        if (m < 10) {
          m = "0" + m;
        }
        if (s < 10) {
          s = "0" + s;
        }
        return `${Y} ${M}/${D} ${h}:${m}:${s}`;
      }
    },
    onRefresh() {
      this.finished = false;
      this.loading = true;      
      this.page=1
      this.onLoad();
    }, 
    onLoad(){ 
      console.log('onLoad'); 
      if(this.cur==0){    
        getHistoryStatic(this.$store.getters.userWallet,this.size).then(res=>{  
        this.refreshing = false;
        this.loading = false;  
        if(res){
          if(this.page==1){this.list=[]}       
          let list=res.map(el=>{
            el=Object.assign({},el)
            return el
          })
          if(res.length==this.size){
            this.page++
          }else{
            this.finished = true;
          }
          this.list=this.list.concat(list)
        }
      })
    }else{
      getHistoryDynamic(this.$store.getters.userWallet,this.size).then(res=>{  
        this.refreshing = false;
        this.loading = false;  
        if(res){
          if(this.page==1){this.list=[]}       
          let list=res.map(el=>{
            el=Object.assign({},el)
            return el
          })
          if(res.length==this.size){
            this.page++
          }else{
            this.finished = true;
          }
          this.list=this.list.concat(list)
        }
      })
    }
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
    getUser(){
      if(!this.$store.getters.userWallet){return}  
      getUser(this.$store.getters.userWallet).then((res) => {
          console.log(res,'userInfo');
          this.userInfo = Object.assign({}, res);
          this.userInfo.staticAmount=this.dexc(res.staticAmount)         
          this.userInfo.dynamicAmount=this.dexc(res.dynamicAmount)           
       
          this.yqWallet=res.referrer
          gethasReferrer(this.$store.getters.userWallet).then(res=>{
          if(!res){
            this.$notify("请绑定推荐人钱包地址");
            this.toPage('/')
          }
        })
          

        });
       
    },
  
    toChange(e){
            this.cur=e
            this.onRefresh()
        },
    onCopy() {
      this.$notify({message:"复制成功",type: "success",});   
    },
    onError() {
      this.$notify("复制失败");
    },
    toPage(e){
      this.$router.push({path:e})
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
    padding-bottom: 200px;
    .title{
        font-size: 30px;
        color: #ffffff;
        margin: 10px 0 20px;
        font-weight: 500;
    }
    .mtop{
      min-height: 292px;
      overflow: hidden;
      position: relative;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 30px;
      box-sizing: border-box;
      margin-bottom: 46px;
      .bg{
        width: 488px;
        height: 488px;
        position: absolute;
        right: 0;
        bottom: -143px;
      }
      .left{
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-direction: column;
        width: calc(80% - 184px);
        .ittx{
          width: 100%;
          margin-top: 16px;
        }
        .amount{
          font-family: DingTalk JinBuTi;
          font-size: 60px;
          font-style: italic;
          font-weight: 400;
          text-align: left;
          color: #ffffff;
          .dw{
            font-size: 22px;
            color: #91969a;
          }

        }
        .txt{
          font-size: 28px;
          color: #7a7a7a;
          margin-top: 14px;
          text-align: left;
        }
      }
      .right{
        .img{
          width: 164px;
        }
      }
    }
    .mybox{
      background: #111111;
      padding: 30px;
      .item{
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 64px;
        margin: 15px 0;
        .left{
          font-size: 26px;
          color: #ffffff;
          font-weight: 500;
        }
        .right{
          background: #010101;
          height: 48px;
          max-width: 420px;
          padding: 0 20px;
          display: flex;
          align-items: center;
          .addr{
            color: #ffffff;
            min-width: 280px;
            max-width: 370px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
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
        .btn{
          cursor: pointer;
          .img{
            width: 28px;
            height: 28px;
          }
        }
      }
    }
    .tringbox{
                margin-top: 88px;
              
                margin-bottom: 28px;
                .line{
                  width: 100%;
                  height: 1px;
                  background: #97979730;
                  margin: 50px auto;
                }
                .sitem{
                    margin-top: 28px;
                    padding: 0 36px;
                    .trop{
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        .name{
                            font-size: 28px;
                            color: #7d7d7d;
                        }
                        .jl{
                            font-size: 28px;
                            color: #2B60F3;
                        }
                    }
                    .nbox{
                        margin-top: 34px;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        .left{
                            display: flex;
                            align-items: center;
                            .ico{
                                width: 76px;
                                height: 76px;
                                .img{
                                    width: 76px;
                                }
                            }
                            .sprice{
                                margin-left: 20px;
                                font-size: 36px;
                                color: #ffffff;
                            }
                        }
                        .right{
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            width: 152px;
                            height: 60px;
                            background: #2B60F3;
                            border-radius: 6px;
                            .img{
                                width: 32px;
                            }
                            .txt{
                                margin-left: 12px;
                                font-size: 28px;
                                color: #ffffff;
                            }
                        }
                    }
                }
            }
    .tablist{
        margin-top: 160px;
        background: #010101;
        .tabs{
            display: flex;
            align-items: center;
            padding: 0 34px 20px;
            border-bottom: 1px solid #97979730;
            .nav{
                font-size: 28px;
                color: #91969a;
                cursor: pointer;
                margin-right: 50px;
            }
            .act{
                font-size: 32px;
                color: #ffffff;
                position: relative;
            }
            .act::after{
                content: "";
                width: 40px;
                height: 6px;
                background: #2B60F3;
                position: absolute;
                bottom: -23px;
                left: 50%;
                transform: translateX(-50%);
            }
        }
        .list{
          padding: 30px;
          box-sizing: border-box;
          ::v-deep.van-list{
      height: 80vh;
    overflow: auto;
    }
          .sheader{
            display: flex;
            justify-content: space-between;
            align-items: center;
            .txt{
              font-size: 24px;
              color: #91969a;
            }
          }
          .item{
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 34px;
            margin: 40px 0;
            .txts{
              font-size: 24px;
              color: #ffffff;
            }
          }
        }
        .noData{
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: column;
		justify-content: center;
    min-height: 50vh;
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
      margin: 10px 106px;
      text-align: left;
    }
    .top {
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
      color: #848484;
      line-height: 44px;
      margin: 10px 0 15px;
      padding: 0 22px;
      box-sizing: border-box;
      text-align: left;
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
        background: #2B60F3;
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
      .txt {
        color: #2a2a2a;
        font-size: 24px;
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
      background: #2B60F3;
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