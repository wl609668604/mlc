import Web3Modal from "web3modal";
import Web3 from "web3";

// const WalletConnectProvider = window.WalletConnectProvider.default;

const web3Modal = new Web3Modal({
  cacheProvider: true, // optional
  providerOptions: {
  },
});

let web3 = null;
let provider = null;

export async function connectWallet() {
  try {
    provider = await web3Modal.connect();
    web3 = new Web3(provider);
    return { web3 };
  } catch (error) {
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

export function getUserAddress() {
  return web3
    ? web3.eth.getAccounts().then(accounts => accounts[0])
    : Promise.resolve(null);
}
