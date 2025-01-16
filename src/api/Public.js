//import Web3 from 'web3'
import { connectWallet, getUserAddress } from "./web3_modal";
import USDT from './bnbUsdt.json'
import DAPP from './dapp.json'
import { Toast } from 'vant';
//正式
const ADDRESS_DAPP ="0xc987A1CDec273C103D796bBCe4b1De741710e2A7"
const ADDRESS_MLC ="0xAeb68939e604b403bD1d53Deb910b01054cfE539"
const ADDRESS_MLB ="0xFc2f313A18dbaf6c3FA7dE2D5F878b90cC1d270f"
const ADDRESS_USDT ="0x55d398326f99059fF775485246999027B3197955"

// let ethereum = window.ethereum
//     let i = setInterval(() => {
//     if ((typeof window.ethereum) !== 'undefined') {
//         ethereum = window.ethereum      
//         handleWatch()  
//         clearInterval(i)  
//     }
//     }, 1000);

// export async function set(){
//     ethereum = window.ethereum
// }


// export async function handleWatch () {
//     if (!window.ethereum) {
//         //console.log('Metamask is not installed!')
//         return false
//       }
//     window.ethereum.on('accountsChanged',  (accounts) => {
//       if(accounts[0]){
//         //         const { web3 } = await connectWallet();
        // if (!web3) {
        //   throw new Error("web3 is not connected");
        // }
        // const address = (await getUserAddress()) || "";
//         // let msg = web3.utils.keccak256('授权签名');
//         // let ht= await web3.eth.sign(msg, accounts[0])
//         // .then(res=>{return res});  
//         // if(ht){
//       sessionStorage.setItem('userWallet',accounts[0])  
//     //   store.commit("userWallet", accounts[0]);  
//     }else{
//         sessionStorage.removeItem('userWallet')
//       }     
//     })
// }
// export async function connectTron() {
//             const { web3 } = await connectWallet();
        // if (!web3) {
        //   throw new Error("web3 is not connected");
        // }
        // const address = (await getUserAddress()) || "";
//     //console.log(web3.utils.toDecimal(ethereum.chainId),ethereum.chainId);
//     if (web3.utils.toDecimal(ethereum.chainId)!='0x38') {
        
//         try {
//             await window.ethereum.request({
//                 method: 'wallet_switchEthereumChain',
//                 params: [{
//                     chainId: Web3.utils.numberToHex(56), // 目标链ID
//                 }]
//             })
//             // //console.log('now',ethereum.chainId);
//             return true
//         } catch (e) {
//             // //console.log('now',e);
//             if (e.code == 4902) {
//                 try {
//                     await window.ethereum.request({
//                         method: 'wallet_addEthereumChain',
//                         params: [{
//                             chainId: Web3.utils.numberToHex(56), // 目标链ID
//                             chainName: 'Arbitrum One',
//                             nativeCurrency: {
//                                 name: 'BNB',
//                                 symbol: 'BNB',
//                                 decimals: 18
//                             },
//                             rpcUrls: ['https://arbitrum-mainnet.infura.io'], // 节点
//                             blockExplorerUrls: ['https://explorer.arbitrum.io']
//                         }]
//                     })
//                     return true
//                 } catch (ee) {
//                     //console.log('//---------', ee);

//                 }
//             } else if (e.code === 4001) return false
//         }    
//     }
//     const eth_requestAccounts = await ethereum.request({ method: "eth_requestAccounts" });
//     // return ["0xf7168b41ECF20c64746eb6449a80B3f86457118C"]
//     return eth_requestAccounts
// }

  // 判断时候绑定



  
  export function gethasReferrer(address) {
    let run = async () => {
          const { web3 } = await connectWallet();
          if (!web3) {
            throw new Error("web3 is not connected");
          }
          const address = (await getUserAddress()) || "";

          let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP);
          let result = await unioContract.methods.hasReferrer(address).call();
         return result
    };
    return run();
  }

  export function getCanBind(address) {
    let run = async () => {
          const { web3 } = await connectWallet();
          if (!web3) {
            throw new Error("web3 is not connected");
          }
          const address = (await getUserAddress()) || "";
          
          let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP);
          let result = await unioContract.methods.canBind(address).call();
         return result
    };
    return run();
  }



   // 查询MLB代币授权数量
   export function getUserExtras(address) {    
    let run = async () => {
        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
          let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP, {
              from:address
          });
          let result = await unioContract.methods.userExtras(address).call();
         return result
    };
    return run();
  }

// 查询价格
export function getPrice(address) {    
    let run = async () => {
        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        //const address = (await getUserAddress()) || "";
          let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP, {
              from:address
          });
          let price = await unioContract.methods.priceMlc().call();  
         return price/10**6 
    };
    return run();
  }

  // 查询价格
export function getPrices(address) {    
    let run = async () => {
        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";

          let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP, {
              from:address
          });
          let price = await unioContract.methods.priceMlb().call();  
         return price/10**6 
    };
    return run();
  }



 

 // 查询代币是否授权
 export function getProved(address) {
    let run = async () => {

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
          let unioContract = await new web3.eth.Contract(USDT, ADDRESS_MLC, {
              from:address
          });
          let result = await unioContract.methods.allowance(address,ADDRESS_DAPP).call()/(10**18);
         return result 
    };
    return run();
  }
  export function getProveds(address) {
    let run = async () => {

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
          let unioContract = await new web3.eth.Contract(USDT, ADDRESS_MLC, {
              from:address
          });
          let result = await unioContract.methods.allowance(address,ADDRESS_DAPP).call()/(10**18);
         return result 
    };
    return run();
  }
  
 // 授权MLC
 export async function toApprove(_address,num) {

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
        let unioContract = await new web3.eth.Contract(USDT, ADDRESS_MLC);  
        let amount = web3.utils.toWei(num + '','ether');
        let gas = await web3.eth.getGasPrice();
        //console.log(gas);
        try {
          const receipt = await unioContract.methods.approve(ADDRESS_DAPP, amount).send({
            from: address,
            gas:"1000000",
            gasPrice: "1000000000",
          });
          console.log('Transaction successful:', receipt);
        } catch (error) {
          if (error.message.includes('in progress')) {
            // 如果错误信息包含 "in progress"，什么也不做
          } else {
            // 其他错误，抛出异常
            return false;
            //throw error;
          }
        }

        return true;
  }
 // 授权MLB
 export async function toApproves(_address,num) {

    const { web3 } = await connectWallet();
    if (!web3) {
      throw new Error("web3 is not connected");
    }
    const address = (await getUserAddress()) || "";
    let unioContract = await new web3.eth.Contract(USDT, ADDRESS_MLB);  
    let amount = web3.utils.toWei(num + '','ether');
    //console.log(gas);
    try {
      const receipt = await unioContract.methods.approve(ADDRESS_DAPP, amount).send({
        from: address,
        gas:"1000000",
        gasPrice: "1000000000",
      });
      console.log('Transaction successful:', receipt);
    } catch (error) {
      if (error.message.includes('in progress')) {
        // 如果错误信息包含 "in progress"，什么也不做
      } else {
        // 其他错误，抛出异常
        return false;
        //throw error;
      }
    }

    return true;
  }
  export function Sign(address) {
    let run = async () => {

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
        let msg = web3.utils.utf8ToHex('Welcome to MLB');
        //console.log(msg,address);
        let ht= await web3.eth.personal.sign(msg, address)
        .then(res=>{return res}).catch(err=>{
          // Toast(err)
          //console.log(err);
          return false});
       return ht?ht:false
  };
  return run();
  }
//   获取用户信息
export async function getUser(address) {  
    let run = async () => {

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
 
    let result = await unioContract.methods.users(address).call(); 
    if(result){
        return  result
    }else{
        return 0
    }
  };
  return run();
}
//   获取用户信息userInfos
export async function getUserInfos(address) {  
    let run = async () => {

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
 
    let result = await unioContract.methods.userInfos(address).call(); 
    if(result){
        return  result
    }else{
        return 0
    }
  };
  return run();
}

//   获取用户每周新增业绩信息
export async function getUserInvestWeek(address) {  
    let run = async () => {

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
 
    let result = await unioContract.methods.userInvestWeek(address).call(); 
    if(result){
        return  result
    }else{
        return 0
    }
  };
  return run();
}
//   获取总数据
export async function getTotalData(address) {  
    let run = async () => {

             const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
 
    let result = await unioContract.methods.totalData(address).call(); 
    if(result){
        return  result
    }else{
        return 0
    }
  };
  return run();
}
// 绑定邀请人
export async  function toBind(address,referrer){
    //console.log(address,referrer);

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
        let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP);

        try {
          const receipt = await unioContract.methods.bindReferrer(referrer).send({
            from: address,
            gas:"1000000",
            gasPrice: "1000000000",
          });
          console.log('Transaction successful:', receipt);
        } catch (error) {
          if (error.message.includes('in progress')) {
            // 如果错误信息包含 "in progress"，什么也不做
          } else {
            // 其他错误，抛出异常
            return false;
            //throw error;
          }
        }

      return true;
}
// 用户创建订单
export async  function toBookOrder(address,num){

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
        let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP);
       let amount = web3.utils.toWei(num + '', 'ether');

       try {
        const receipt = await unioContract.methods.bookOrder(amount).send({
          from: address,
          gas:"1000000",
          gasPrice: "1000000000",
        });
        console.log('Transaction successful:', receipt);
      } catch (error) {
        if (error.message.includes('in progress')) {
          // 如果错误信息包含 "in progress"，什么也不做
        } else {
          // 其他错误，抛出异常
          return false;
          //throw error;
        }
      }

      return true;
}
  // 用户赎回订单函数
  export async function getRedeemOrder(address) {  
    const { web3 } = await connectWallet();
    if (!web3) {
      throw new Error("web3 is not connected");
    }
    const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP); 
     
     try {
      const receipt = await unioContract.methods.redeemOrder().send({
        from: address,
        gas:"1000000",
        gasPrice: "1000000000",
      });
      console.log('Transaction successful:', receipt);
    } catch (error) {
      if (error.message.includes('in progress')) {
        // 如果错误信息包含 "in progress"，什么也不做
      } else {
        // 其他错误，抛出异常
        return false;
        //throw error;
      }
    }

    return true;
}
// 我的社区显示直推信息
export async function getDirectReferralsInfo(address) {  
    let run = async () => {

             const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
     //console.log(address);
    let result = await unioContract.methods.getDirectReferralsInfo(address).call(); 

    if(result){
        return  result
    }else{
        return ""
    }
  };
  return run();
}

export function getMymlc(address) {
    let run = async () => {

                  const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
          let unioContract = await new web3.eth.Contract(USDT, ADDRESS_MLC);
          let result = await unioContract.methods.balanceOf(address).call();
          if(result){
            return  web3.utils.fromWei(result+'', 'ether');
        }else{
            return 0
        }
    };
    return run();
  }
  export function getMymlb(address) {
    let run = async () => {

                  const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
          let unioContract = await new web3.eth.Contract(USDT, ADDRESS_MLB);
          let result = await unioContract.methods.balanceOf(address).call();
          if(result){
            return  web3.utils.fromWei(result+'', 'ether');
        }else{
            return 0
        }
    };
    return run();
  }
// 静态提现
export async function toWithdrawal(address){

        const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
        let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP);

        try {
          const receipt = await unioContract.methods.withdrawalStatic().send({
            from: address,
            gas:"1000000",
            gasPrice: "1000000000",
          });
          console.log('Transaction successful:', receipt);
        } catch (error) {
          if (error.message.includes('in progress')) {
            // 如果错误信息包含 "in progress"，什么也不做
          } else {
            // 其他错误，抛出异常
            return false;
            //throw error;
          }
        }
        return true;
}

// 动态提现
export async  function toWithdrawalDynamic(address){
  const { web3 } = await connectWallet();
  if (!web3) {
    throw new Error("web3 is not connected");
  }
  const address = (await getUserAddress()) || "";
  let unioContract = await new web3.eth.Contract(DAPP, ADDRESS_DAPP);

  try {
    const receipt = await unioContract.methods.withdrawalDynamic().send({
      from: address,
      gas:"1000000",
      gasPrice: "1000000000",
    });
    console.log('Transaction successful:', receipt);
  } catch (error) {
    if (error.message.includes('in progress')) {
      // 如果错误信息包含 "in progress"，什么也不做
    } else {
      // 其他错误，抛出异常
      return false;
      //throw error;
    }
  }
  return true;
}

// 获取出入金记录
export async function getHistoryWallet(address,status) {  
    let run = async () => {

             const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
    let result = await unioContract.methods.getHistoryWallet(address,status).call(); 

    if(result){
        return  result
    }else{
        return []
    }
  };
  return run();
}

// 静态收益记录
export async function getHistoryStatic(address,status) {  
    let run = async () => {

             const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
    let result = await unioContract.methods.getHistoryStatic(address,status).call(); 

    if(result){
        return  result
    }else{
        return []
    }
  };
  return run();
}
// 动态收益记录
export async function getHistoryDynamic(address,status) {  
    let run = async () => {

             const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
    let result = await unioContract.methods.getHistoryDynamic(address,status).call(); 

    if(result){
        return  result
    }else{
        return []
    }
  };
  return run();
}

// 排行榜
export async function getRankUsers() {  
    let run = async () => {

             const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || ""; 
     let unioContract= await new web3.eth.Contract(DAPP, ADDRESS_DAPP);  
    let result = await unioContract.methods.getRankUsers().call(); 

    if(result){
        return  result
    }else{
        return []
    }
  };
  return run();
}


export  function toTransfersMlb(address,toAddress,num){
    let run = async () => {
                const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
        let unioContract = await new web3.eth.Contract(USDT, ADDRESS_MLB, {
            from:address
        });
        let  amount = web3.utils.toWei(num + '', 'ether');
        let result = await unioContract.methods.transfer(toAddress,amount).send({from:address}).catch(err => {
            Toast(err.message)
        });
        if(result){
            return result.transactionHash
        }else{
            return false
        }
  };
  return run();

}


export  function toTransfersMlc(address,toAddress,num){
    let run = async () => {
                const { web3 } = await connectWallet();
        if (!web3) {
          throw new Error("web3 is not connected");
        }
        const address = (await getUserAddress()) || "";
        let unioContract = await new web3.eth.Contract(USDT, ADDRESS_MLC, {
            from:address
        });
        let  amount = web3.utils.toWei(num + '', 'ether');
        let result = await unioContract.methods.transfer(toAddress,amount).send({from:address}).catch(err => {
            Toast(err.message)
        });
        if(result){
            return result.transactionHash
        }else{
            return false
        }
  };
  return run();

}










































