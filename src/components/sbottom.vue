<template>
  <div class="buttoms">
    <div class="tabnav">
      <div class="item" @click="gbsmenu('/')">
        <div class="icon">
          <img src="../assets/img/ico_1s.png" alt="" v-if="active=='/'"   class="img">
          <img src="../assets/img/ico_1.png" alt="" v-else class="img">
        </div>
        <div class="txt" :class="active=='/'?'act':''">首页</div>
      </div>
      <div class="item" @click="gbsmenu('/Trading')">
        <div class="icon">
          <img src="../assets/img/ico_2s.png" alt="" v-if="active=='/Trading'"  class="img">
          <img src="../assets/img/ico_2.png" alt="" v-else  class="img">
        </div>
        <div class="txt" :class="active=='/Trading'?'act':''">交易</div>
      </div>
      <div class="item" @click="gbsmenu('/My')">
        <div class="icon">
          <img src="../assets/img/ico_3s.png" alt="" v-if="active=='/My'"  class="img">
          <img src="../assets/img/ico_3.png" alt="" v-else  class="img">
        </div>
        <div class="txt" :class="active=='/My'?'act':''">我的</div>
      </div>
    </div>
  </div>
  </template>
  <script >
export default {
  data(){
    return{
      active:"/",
    }
  },
  watch: {
    "$route.path": function (val) {
      this.active=this.$route.path;
    },
    deep: true,
    immediate: true,
  },
  created(){
    this.active=this.$route.path;
  },
  methods:{
    gbsmenu(e) {
      if (e == this.active) {
        return;
      }  
      if(e){
        this.$router.push({path:e})
      }
    },
  }
}
  </script>
  <style lang="scss" scoped>  
  .buttoms {
    font-family: "PingFang";
    font-weight: bold;
    position: fixed;
    background: #1A1A1A;
    color: #909389;
    width: 750px;
  margin: 0 auto;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    .tabnav{
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 24px;
      cursor: pointer;
      .item{
        width: 33%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        .txt{
          font-size: 20px;
          color: #909389;

        }
        .act{
          color: #3E64C7;
        }
      }
    }
  }
</style>