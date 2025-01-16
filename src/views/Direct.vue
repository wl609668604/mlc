<template>
  <div class="home">
    <div class="header">
        <div class="back" @click="toPage('/My')">
            <img src="../assets/img/ico_back.png" alt="" srcset="" class="img">
        </div>
        <div class="title">直推列表</div>
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
            <div class="txt tl">钱包地址</div>
            <div class="txt">等级</div>
            <div class="txt tr">数量</div>
        </div>
        <div class="item" v-for="(item,i) in list" :key="i">
            <div class="txts">{{item.userAddress|yingcang}}</div>
            <div class="txth">LV {{item.userLevel}}</div>
            <div class="txtr">{{dexc(item.runInvestment)}}/MLC</div>
        </div>
        <div  class="noData" v-if="list.length==0" >
                  <img src="../assets/img/no.png" alt="" >
                  <div class="ttx">暂无数据</div>
                </div>
    </div>
  </van-list>
        </van-pull-refresh>
  </div>
</template>

<script>
import {getDirectReferralsInfo} from "@/api/Public";
import Web3 from 'web3'
export default {
    data() {
      return {
        userWallet:"",
        loading: false,
        finished: false,
        refreshing: false,
        page:1,
        size:10,
        list:[],
      }
    },
    created(){
      this.userWallet=this.$store.getters.userWallet  
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
    methods:{
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
      onRefresh() {
      this.finished = false;
      this.page=1
      this.loading = true;
      this.onLoad();
    }, 
    onLoad(){   
      if(!this.$store.getters.userWallet){return}   
      getDirectReferralsInfo(this.$store.getters.userWallet,this.size).then(res=>{  
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
      
    },  
    toPage(e){
      this.$router.push({path:e})
    },
    }
}
</script>

<style lang="scss" scoped>
      .home{
        background: #111111 ;
    background-size: contain;
    background-position: center bottom;
    overflow-x: hidden;
    width: 750px;
    margin: 0 auto;
    min-height: 100vh;
    padding-bottom: 200px;
    .header{
        position: relative;
        background: #010101;
        height: 64px;
        padding: 26px 26px ;
        padding-bottom: 30px;
    
        .title{
            font-size: 30px;
        color: #ffffff;
        font-weight: 500;
        }
        .back{
            position: absolute;
            left: 30px;
            top: 50%;
            transform: translateY(-50%);
            .img{
                width: 32px;
                height: 32px;
            }
        }
    }
    .list{
          padding: 40px 30px;
          box-sizing: border-box;
          ::v-deep.van-list{
      height: 80vh;
    overflow: auto;
    }
          .sheader{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            .txt{
              font-size: 24px;
              color: #91969a;
              width: 33%;
            }
            .tl{
              text-align: left;
            }
            .tr{
              text-align: right;
            }
          }
          .item{
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 80px;
            .txts{
              font-size: 28px;
              color: #ffffff;
              width: 33%;
              max-width: 50%;
              overflow: hidden;
              text-align: left;
            }
            .txth{
                font-size: 28px;
                color: #ffffff;
                width: 33%;
                text-align: center;
            }
            .txtr{
                  font-size: 28px;
                  color: #ffffff;
                  font-weight: 600;
                font-style: italic;
                width: 33%;
                text-align: right;

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

</style>