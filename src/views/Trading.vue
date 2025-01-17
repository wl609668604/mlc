<template>
    <div class="home">
        <div class="title">交易</div>
        <div class="topbox">
            <div class="top">
                <van-tabs v-model="current" swipeable class="tab"
         background="transparent" 
         color="#2B60F3" 
        line-height="2px"
        line-width="20px"
        @change="changer"
        title-active-color="#ffffff">
    <van-tab title="托管" name='1' class="item">
    </van-tab>
    <van-tab title="提现" name='2' class="item">
    </van-tab>
    </van-tabs>
    <div class="right" @click="toPage('/Records')">
        <img src="../assets/img/ico_jl.png" alt="" srcset=""  class="img">
        <div class="txt">出入金记录</div>
    </div>
            </div>
            <div class="buybox">
                <div class="laber">{{current==1?'托管数量':'提现数量'}} </div>
                <div class="sinput" v-if="current==1">
                    <div class="txt">MLC</div>
                    <input type="text" placeholder="请输入托管数量" v-model="xzNum" class="input">
                </div>
                <div class="sinput" v-if="current==2">
                    <div class="txt">MLC</div>
                    <input type="text" placeholder="0" v-model="nums" readonly class="input">
                </div>
                <div class="price" >参考单价 {{price}} USDT</div>
            <div class="buttom">       
          <van-button type="primary" 
            :loading="loading"
            :class="xzNum>0?'act':''"
            v-if="current==1"
            @click="toJoin"
            class="btn ">
            参与托管
            </van-button>
            <van-button type="primary" 
            :loading="loadings"
            :class="nums>0?'act':''"
            @click="toRedeem"
            v-if="current==2"
            class="btn ">
            提现
            </van-button>
            </div> 


            <div class="tringbox">
                <div class="sitem">
                    <div class="trop">
                        <div class="name">MLB</div>
                        <!-- <div class="jl">互转记录</div> -->
                    </div>
                    <div class="nbox">
                        <div class="left">
                            <div class="ico">
                                <img src="../assets/img/ico_mlb.png" alt="" srcset=""  class="img">
                            </div>
                            <div class="sprice">{{myMlb||0}}/MLB</div>
                        </div>
                        <div class="right" @click="toHzshow(1)">
                            <img src="../assets/img/ico_hz.png" alt="" srcset=""  class="img">
                            <div class="txt">互转</div>
                        </div>
                    </div>
                </div>
                <div class="line"></div>
                <div class="sitem">
                    <div class="trop">
                        <div class="name">MLC</div>
                        <!-- <div class="jl">互转记录</div> -->
                    </div>
                    <div class="nbox">
                        <div class="left">
                            <div class="ico">
                                <img src="../assets/img/ico_mlc.png" alt="" srcset=""  class="img">
                            </div>
                            <div class="sprice">{{myMlc||0}}/MLC</div>
                        </div>
                        <div class="right" @click="toHzshow(2)">
                            <img src="../assets/img/ico_hz.png" alt="" srcset=""  class="img">
                            <div class="txt" >互转</div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <div class="tradingList">
                <div class="rtitle">量化交易记录</div>
                <div class="list">
                  <div  class="noData">
                  <img src="../assets/img/no.png" alt="" >
                  <div class="ttx">暂无数据</div>
                </div>
                    <!-- <div class="item">
                        <div class="stop">
                            <div class="left">
                                <div class="ico">
                                    <img src="../assets/img/ico_bsc.png" alt="" srcset=""  class="img">
                                </div>
                                <div class="name">BSC</div>
                            </div>
                            <div class="right">
                                <div class="txt">盈利</div>
                                <div class="num gree">235</div>
                            </div>
                        </div>
                        <div class="sbottom">
                            <div class="nabs ls">
                                <div class="txt">交易时间</div>
                                <div class="vals">2025-01-05</div>
                            </div>
                            <div class="nabs">
                                <div class="txt">hash</div>
                                <div class="vals">U8esoWslskf3494</div>
                            </div>
                            <div class="nabs rs">
                                <div class="txt">投入金额</div>
                                <div class="vals">200</div>
                            </div>
                        </div>
                    </div> -->


                    <!-- <div class="item">
                        <div class="stop">
                            <div class="left">
                                <div class="ico">
                                    <img src="../assets/img/ico_eth.png" alt="" srcset=""  class="img">
                                </div>
                                <div class="name">ETH</div>
                            </div>
                            <div class="right">
                                <div class="txt">盈利</div>
                                <div class="num gree">235</div>
                            </div>
                        </div>
                        <div class="sbottom">
                            <div class="nabs ls">
                                <div class="txt">交易时间</div>
                                <div class="vals">2025-01-05</div>
                            </div>
                            <div class="nabs">
                                <div class="txt">hash</div>
                                <div class="vals">U8esoWslskf3494</div>
                            </div>
                            <div class="nabs rs">
                                <div class="txt">投入金额</div>
                                <div class="vals">200</div>
                            </div>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>
        <div class="tablist">
            <div class="tabs">
                <div class="nav " :class="cur==0?'act':''" @click="toChange(0)">我的持仓</div>
                <div class="nav" :class="cur==1?'act':''" @click="toChange(1)">每日利息复利</div>
            </div>
            <div class="list">
              <div  class="noData">
                  <img src="../assets/img/no.png" alt="" >
                  <div class="ttx">暂无数据</div>
                </div>
            </div>
        </div>

        <van-popup v-model="lqshows" round :close-on-click-overlay="false">
      <div class="popup">
        <div class="ntop">
          <div class="title">完成钱包确认</div>
          <img
            src="../assets/img/gbs.png"
            alt=""
            class="close"
            v-if="!lqloading"
            @click="
              lqshows = false;
              loading = false;
            "
          />
        </div>
        <div class="rbox">
          <div class="num">{{ xzNum }}</div>
          <div class="txt">MLC</div>
          <img src="../assets/img/ico_mlc.png" alt="" srcset="" class="ico" />
        </div>
        <div class="xbox">
          <div class="txt">授权数量</div>
          <div class="num">{{ sqUsdtNum }} MLC</div>
        </div>
        <div class="flsz">
          <van-button
            :loading="lqloading"
            type="primary"
            @click="scSelects"
            class="btn"
          >
            确认</van-button
          >
        </div>
      </div>
    </van-popup>

    <van-popup v-model="hzshow" round :close-on-click-overlay="!hzloading">
      <div class="popup">
        <div class="ntop">
          <div class="title">互转</div>
          <img
            src="../assets/img/gbs.png"
            alt=""
            class="close"
            v-if="!hzloading"
            @click="
              hzshow = false
            "
          />
        </div> 
        <div>
          <input type="text" class="input" placeholder="请输入接收地址" v-model="hzAddres" />
        </div>          
        <div>
          <input type="text" class="input" placeholder="请输入划转数量" v-model="hzNum" @input="jsNun" />
        </div>
        <div class="balance">可用余额：{{hzTypr==1?myMlb:myMlc}}{{hzTypr==1?'MLB':"MLC"}}</div>
        <van-button
          :loading="hzloading"
          type="primary"
          @click="toHz()"
          class="btn"
          
          >确定互转</van-button
        >
      </div>
    </van-popup>

        <Bottom/>
        </div>
      </template>
      
      <script>
        import Bottom from "../components/sbottom.vue";
        import {getPrice,  getProved,toBookOrder,getMymlc,getMymlb,getRedeemOrder,getUser,toTransfersMlb,toTransfersMlc,gethasReferrer,
  toApprove,} from "@/api/Public";
  import Web3 from 'web3'
      export default {
        name: "Home",
    components: { Bottom},
    data() {
      return {
        userWallet:"",
        price:"0",
        list:[],
        cur:0,
        current:1,
        loading:false,
        loadings:false,
        num:"",
        nums:"",
        xzNum:"",
        sqUsdtNum:"",
        sqNum:"",
        lqshows:false,
        lqloading:false,
        myMlc:"",
        myMlb:'',
        userInfo:"",
        hzshow:false,
        hzloading:false,
        hzAddres:"",
        hzNum:'',
        hzTypr:1
        
      }
    },
    created(){
      this.userWallet=this.$store.getters.userWallet  
     this.getPrice()
     this.getMymlc()
     this.getMymlb()
     this.getUser()
    },
    methods:{
      jsNun(){
        setTimeout(() => {
          if (this.hzTypr==1) {
            this.hzNum=this.hzNum-this.myMlb>0?this.myMlb:this.hzNum
          }else{
            this.hzNum=this.hzNum-this.myMlc>0?this.myMlc:this.hzNum
          }          
          
        }, 100);
      },
      toHzshow(e){
        this.hzTypr=e
        this.hzAddres=""
        this.hzNum=""
        this.hzshow=true
      },
      toHz(){
        if(!this.$store.getters.userWallet){return}
        if(!this.hzAddres){return}
        if(!this.hzNum){return}
        if(this.hzAddres.indexOf('0x')==-1){
          this.$notify("请输入正确的钱包地址")
          return
        }
        this.hzloading=true
        if(this.hzTypr==1){
          toTransfersMlb(this.$store.getters.userWallet,this.hzAddres,this.hzNum).then(res=>{
            this.hzloading=false
            if(res){
              this.$notify({message:"互转成功",type: "success",});   
              this.getMymlb()
              this.hzshow=false
            }else{
              this.$notify("互转失败")
            }
          })
        }else{
          toTransfersMlc(this.$store.getters.userWallet,this.hzAddres, this.hzNum).then(res=>{
            this.hzloading=false
            if(res){
              this.$notify({message:"互转成功",type: "success",});   
              this.getMymlc()
              this.hzshow=false
            }else{
              this.$notify("互转失败")
            }
        })
        }
      },
        getUser(){
          if(!this.$store.getters.userWallet){return}   
        getUser(this.$store.getters.userWallet).then((res) => {
            this.userInfo = Object.assign({}, res);
            this.nums=this.dexc(res.runInvestment)
            gethasReferrer(this.$store.getters.userWallet).then(res=>{
          if(!res){
            this.$notify("请绑定推荐人钱包地址");
            this.toPage('/')
          }
        })
            });
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
        toRedeem(){
          if(!this.$store.getters.userWallet){return}   
            if(this.nums>0){
              this.loadings=true
           getRedeemOrder(this.$store.getters.userWallet).then(res=>{
            this.loadings=false
            if(res){
                this.$notify({message:"提现成功",type: "success",});   
            }else{
                this.$notify("提现失败")
            }
           })
        }
        },
        getMymlc(){
          if(!this.$store.getters.userWallet){return}   
            getMymlc(this.$store.getters.userWallet).then(res=>{
                this.myMlc=res
            })
        },
        getMymlb(){
          if(!this.$store.getters.userWallet){return}   
          getMymlb(this.$store.getters.userWallet).then(res=>{
                this.myMlb=res
            })
        },
        async scSelects() {
          if(!this.$store.getters.userWallet){return}   
      await this.toGetsq();
      if (this.xzNum <= 0) {
        return;
      }
      if (!this.userWallet) {
        return;
      }
      this.lqloading = true;
      if (this.sqUsdtNum - this.sqNum > 0) {
        let num = Math.ceil(this.sqUsdtNum);
        toApprove(this.userWallet, num).then((res) => {
          // //console.log(res);
          if (res) {
            this.sqNum = this.sqUsdtNum;
            this.scSelects();
          } else {
            this.lqloading = false;
          }
        });
      } else {
        toBookOrder(this.userWallet, this.xzNum).then((res) => {
          //console.log(res);
          this.lqloading = false;
          if (res) {
            this.lqshows = false;
            this.loading = false;
            this.upUser();
            this.$notify({
              message: "托管成功",
              type: "success",
            });
          } else {
            this.$notify({
              message: "托管失败",
              type: "danger",
            });
          }
        });
      }
    },
    upUser(){
      this.getMymlb()
    },
    async toGetsq() {
      this.sqNum = await getProved(this.userWallet).then((res) => {
        return res;
      });
    },
    async  toJoin(){
        if(this.xzNum>0){
        await this.getMymlc()
        console.log(this.myMlc);
            if (this.myMlc - this.xzNum >= 0) {
        this.loading = true;
        this.sqUsdtNum = this.xzNum;
        await this.toGetsq();
        this.lqshows = true;
      } else {
        this.$notify("余额不足");
      }
    }
        },
        toChange(e){
            this.cur=e
        },
        changer(e){
            if(this.loading){return}
            this.current=e
        },
        getPrice(){
            getPrice().then(res=>{
                this.price=res
            })
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
    .top{
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 30px 30px 0;
        .tab{
                .item{
                    font-size: 30px;
                    margin-right: 60px !important;
                }
            }
            .right{
                display: flex;
                align-items: center;
                cursor: pointer;
                .img{
                    width: 36px;
                }
                .txt{
                    font-size: 28px;
                    color: #2B60F3;
                    margin-left: 2px;
                }
            }
    }
    .buybox{
        background: #111111;
        padding: 30px;
        box-sizing: border-box;
        border-radius: 32px 32px 0 0;

        .laber{
            font-size: 28px;
            font-weight: 500;
            color: #ffffff;   
            text-align: left;       
        }
        .sinput{
            margin-top: 34px;
                display: flex;
                align-items: center;
                background: #1a1a1a;
                padding: 30px 40px;
                box-sizing: border-box;
                .txt{
                    font-size: 30px;
                    color: #ffffff;
                    margin-right: 18px;
                }
                .input{
                    border: none;
                    background: transparent;
                    color: #ffffff;
                    font-size: 30px;
                }
            }
            .price{
                margin-top: 20px;
                color: #ffffff;
                font-size: 22px;
                text-align: left;
            }
            .buttom{
                margin-top: 80px;
                .btn{
                    width: 100%;
                    height: 84px;
                    border-radius: 6px;
                    background: #282828;
                    color: #ffffff;
                    font-size: 28px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border: none;
                }
                .act{
                    background: #2B60F3;
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
                                overflow: hidden;
                                max-width: 360px;
                                text-overflow: ellipsis;
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
    }
    .tradingList{
        background: #010101;
        .rtitle{
            font-size: 28px;
            color: #ffffff;
            text-align: left;
            padding: 40px 30px ;
        }
        .list{
          
        min-height: 20vh;
            background: #111111;
            padding: 1px 30px;
            box-sizing: border-box;
            .item{
                margin: 40px 0 30px;
                .stop{
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
                        .name{
                            font-size: 36px;
                            font-weight: 500;
                            color: #ffffff;
                            margin-left: 16px;
                        }
                    }
                    .right{
                        display: flex;
                        flex-direction: column;
                        align-items: flex-end;
                        .txt{
                            font-size: 24px;
                            color: #999999;
                        }
                        .num{
                            font-size: 32px;
                            font-weight: 500;
                            color: #ffffff;
                            margin-top: 12px;
                        }
                        .gree{
                            color: #01B494;
                        }
                    }
                }
                .sbottom{
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    height: 134px;
                    background: #1d1d1d;
                    border-radius: 18px;
                    padding: 32px 20px;
                    margin-top: 26px;
                    box-sizing: border-box;
                    .nabs{
                        max-width: 30%;
                        .txt{
                            font-size: 20px;
                            color: #414141;
                        }
                        .vals{
                            font-size: 28px;
                            color: #ffffff;
                            overflow: hidden;
                           text-overflow: ellipsis;
                           margin-top: 18px;
                        }
                    }
                    .ls{
                        text-align: left;
                    }
                    .rs{
                        text-align: right;
                    }
                }
            }
        }
    }
    .tablist{
        margin-top: 60px;
        background: #010101;
        .tabs{
            display: flex;
            align-items: center;
            padding: 0 34px 20px;
            border-bottom: 1px solid #97979730;
            .nav{
                font-size: 28px;
                color: #91969a;
                margin-right: 50px;
                cursor: pointer;
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
      margin: 10px 106px;
      text-align: left;
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
   
  }
        }
      </style>