// Linkable is an artifact of the Linkable contract
const Linkable = artifacts.require('Linkable');

module.exports = async function (deployer, network) {
  await deployer.deploy(Linkable);
};
