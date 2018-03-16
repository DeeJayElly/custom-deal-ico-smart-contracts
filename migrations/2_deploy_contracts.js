var CustomDealICO = artifacts.require('../contracts/CustomDealICO.sol');

module.exports = function(deployer) {
    return deployer.deploy(CustomDealICO);
};
