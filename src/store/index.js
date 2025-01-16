
import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    userWallet: "" || sessionStorage.getItem("userWallet"),
    nlist: "" || sessionStorage.getItem("nlist"),
     usdt: "" || localStorage.getItem("usdt"),
    myID: "" || sessionStorage.getItem("myID"),
    intID: "" || sessionStorage.getItem("intID"),
    myFil: "" || sessionStorage.getItem("myFil"),
    language: sessionStorage.getItem('yy') || "en-US",
     theame:localStorage.getItem('theame') || '0',
  },
  mutations: {
    userWallet(state, val) {
      // state.userWallet = val;
      Vue.set(state,'userWallet',val)
      sessionStorage.setItem("userWallet", val);
    },
    language(state,val){
      state.language = val
      // Vue.set(state,'yy',val)
      sessionStorage.setItem('yy', val)
    },
    nlist(state, val) {
      // state.usdt = val;
      Vue.set(state,'nlist',val)
      sessionStorage.setItem("nlist", val);
    },
     usdt(state, val) {
      // state.usdt = val;
      Vue.set(state,'usdt',val)
      localStorage.setItem("usdt", val);
    },
    myID(state, val) {
      state.myID = val;
      // Vue.set(state,'myID',val)
      sessionStorage.setItem("myID", val);
    },
    intID(state, val) {
      // state.intID = val;
      Vue.set(state,'intID',val)
      sessionStorage.setItem("intID", val);
    },
    myFil(state, val) {
      // state.myFil = val;
      Vue.set(state,'myFil',val)
      sessionStorage.setItem("myFil", val);
    },
      theame(state, val) {
      // state.theame = val;
      Vue.set(state,'theame',val)
      localStorage.setItem("theame", val);
    },
  },
  actions: {},
  modules: {},
  getters: {
    userWallet: (state) => state.userWallet,
    nlist: (state) => state.nlist,
    usdt: (state) => state.usdt,
    myID: (state) => state.myID,
    intID: (state) => state.intID,
    myFil: (state) => state.myFil,
    language: (state) => state.language,
     theame: (state)=>state.theame,
  },
});
