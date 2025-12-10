module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // ou "127.0.0.1"
      port: 7545,            // Ganache GUI default
      network_id: "*",
    },
  },

  // Where truffle will put the contract artifacts that Flutter will read
  

  compilers: {
    solc: {
      version: "0.8.21",
      settings: {
        optimizer: {
          enabled: false,
          runs: 200
        }
      }
    }
  }
};
