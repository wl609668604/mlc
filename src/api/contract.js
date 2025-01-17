import { connectWallet, getUserAddress } from "./web3_modal";
import usdt_abi from './bnbUsdt.json'
import mlb_abi from './dapp.json'
const ADDRESS_DAPP ="0xc987A1CDec273C103D796bBCe4b1De741710e2A7"
const ADDRESS_MLC ="0xAeb68939e604b403bD1d53Deb910b01054cfE539"
const ADDRESS_MLB ="0xFc2f313A18dbaf6c3FA7dE2D5F878b90cC1d270f"
const ADDRESS_USDT ="0x55d398326f99059fF775485246999027B3197955"

// 获取地址
export async function getAddress(){
  const {web3} = await connectWallet();
  if (!web3) {
    throw new Error("web3 is not connected");
  }
  return (await getUserAddress()) || "";
}

// 判断是否有绑定
export async function hasReferrer() {
  const {web3} = await connectWallet();
  if (!web3) {
    throw new Error("web3 is not connected");
  }
  const address = (await getUserAddress()) || "";
  const contract = new web3.eth.Contract(mlb_abi, ADDRESS_DAPP);
  return await contract.methods.hasReferrer(address).call();
}

// 绑定上级
export async function canBind(inviter){
  const { web3 } = await connectWallet();
  if (!web3) {
    throw new Error("web3 is not connected");
  }
  const address = (await getUserAddress()) || "";
  const contract = new web3.eth.Contract(mlb_abi, ADDRESS_DAPP);

  try {
    const receipt = await contract.methods.canBind(inviter).send({
      from: address,
      gas:"1000000",
      gasPrice: 100000
    });
    console.log('Transaction successful:', receipt);
  } catch (error) {
    if (error.message.includes('in progress')) {
      // 如果错误信息包含 "in progress"，什么也不做
    } else {
      alert("bind failed:"+error.message);
      // 其他错误，抛出异常
      return false;
      //throw error;
    }
  }
}