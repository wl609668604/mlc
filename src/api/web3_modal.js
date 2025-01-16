// Unpkg imports
import Web3Modal from "bitkeep-web3modal";
import Web3 from "web3";

const WalletConnectProvider = window.WalletConnectProvider.default;

// Web3modal instance
export let web3Modal
// Chosen wallet provider given by the dialog window
export let provider;
// Address of the selected account
export let web3;

export function init() {

  console.log("Initializing example");
  console.log("WalletConnectProvider is", WalletConnectProvider);

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

  console.log("Web3Modal instance is", web3Modal);
}

export async function connectWallet() {
  try {
    init();
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

export function disconnectWallet() {
  // web3Modal.clearCachedProvider();
  // provider = null;
  // web3 = null;
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
