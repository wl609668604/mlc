<template>
  <div class="home">
    <div class="header">
        <div class="back" @click="toPage('/Trading')">
            <img src="../assets/img/ico_back.png" alt="" srcset="" class="img">
        </div>
        <div class="title">出入金记录</div>
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
            <div class="txt">数量</div>
            <div class="txt">状态</div>
            <div class="txt">时间</div>
        </div>
        <div class="item" v-for="(item,i) in list" :key="i">
          <div class="txth">{{dexc(item.amount)}}/MLC</div>
          <div :class="item.status==1?'txtg':'txtr'">{{item.status==1?'入金':"出金"}}</div>
            <div class="txts">{{formatDate(item.timestamp)}}</div>            
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
import {getHistoryWallet} from "@/api/Public";
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
      if(!this.$store.getters.userWallet){return}     
      getHistoryWallet(this.$store.getters.userWallet,this.size).then(res=>{  
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
              max-width: 50%;
              width: 33%;
              overflow: hidden;  
              text-align: right;  
            }
            .txtg{
              color: #3AB83A;
              font-size: 28px;
              width: 33%;
            }
            .txtr{
              color: #BC1111;
              font-size: 28px;
              width: 33%;
            }
            .txth{
              width: 33%;
                font-size: 28px;
                color: #ffffff;
                font-weight: 600;
              font-style: italic;
              text-align: left;  

            }
          }
        }
        .noData{
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: column;
		justify-content: center;
    min-height:50vh;
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