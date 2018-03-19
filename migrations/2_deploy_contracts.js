var CustomDealICO = artifacts.require('./CustomDealICO.sol');

module.exports = function(deployer) {
    return deployer.deploy(CustomDealICO);
};
