// Linkable is an artifact of the Linkable contract
const Linkable = artifacts.require('Linkable');

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(Linkable, accounts[0], { from: accounts[0] });
};
