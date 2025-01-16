import Web3Modal from "web3modal";
import Fortmatic from "fortmatic";
import Web3 from "web3";


const WalletConnectProvider = window.WalletConnectProvider.default;

const web3Modal = new Web3Modal({
  cacheProvider: true, // optional
  providerOptions: {
    walletconnect: {
      package: WalletConnectProvider,
      options: {
        infuraId: "8043bb2cf99347b1bfadfb233c5325c0",
      },
    },
    fortmatic: {
      package: Fortmatic,
      options: {
        key: "pk_test_391E26A3B43A3350",
      },
    },
  },
});

let web3 = null;
let provider = null;

export async function connectWallet() {
  try {
    alert("开始链接");
    provider = await web3Modal.connect();
    web3 = new Web3(provider);
    return { web3 };
  } catch (error) {
    alert("链接报错："+error.message);
    console.error('Error connecting wallet:', error);
    throw error;
  }
}

export function disconnectWallet() {
  web3Modal.clearCachedProvider();
  provider = null;
  web3 = null;
}

export async function getWeb3Instance() {
  if (!web3) {
    const { web3: newWeb3 } = await connectWallet();
    return newWeb3;
  }
  return web3;
}

export async function getUserAddress() {
  if (!web3) {
    const { web3: newWeb3 } = await connectWallet();
  }
  return web3
    ? web3.eth.getAccounts().then(accounts => accounts[0])
    : Promise.resolve(null);
}
