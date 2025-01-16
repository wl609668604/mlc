// Unpkg imports
import Web3Modal from "bitkeep-web3modal";
import Web3 from "web3";

const WalletConnectProvider = window.WalletConnectProvider.default;

let web3 = null;
let provider = null;
let web3Modal = null;

export async function connectWallet() {
  try {
    if(web3Modal == null) {
       await initWeb3Modal();
    }
    //alert("开始链接");
    provider = await web3Modal.connect();
    web3 = new Web3(provider);
    return { web3 };
  } catch (error) {
    alert("链接报错："+error.message);
    console.error('Error connecting wallet:', error);
    throw error;
  }
}

export async function initWeb3Modal() {
    const providerOptions = {
      walletconnect: {
          package: WalletConnectProvider,
          options: {
              rpc: {
                56: 'https://bsc-dataseed.binance.org/'
              },
              network: 'binance',
          }
      }
  };

  web3Modal = new Web3Modal({
      cacheProvider: true, // optional
      providerOptions, // required
      disableInjectedProvider: false, // optional. For MetaMask / Brave / Opera.
  });
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
