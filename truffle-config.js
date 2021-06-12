require('babel-register');
require('babel-polyfill');

const HDWalletProvider = require("@truffle/hdwallet-provider");
const MNEMONIC = '<Enter Mnemonic>';

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    kovan:{
      provider: ()=> HDWalletProvider(MNEMONIC, "https://kovan.infura.io/v3/<PROJECT-ID>"),
      network_id:42,
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
    }
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  // compilers: {
  //   solc: {
  //     optimizer: {
  //       enabled: true,
  //       runs: 200
  //     }
  //   }
  // },
  compilers:{
    solc:{
      version: "0.6.7",
      settings:{
        optimizer:{
          enabled: false,
          runs:200
        },
        evmVersion:"byzantium"
      }
    }
  }


}