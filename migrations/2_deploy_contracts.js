// var CustomDealICO = artifacts.require('./CustomDealICO.sol');
var testICO = artifacts.require('./TestICO.sol');

module.exports = function (deployer) {
    // deployer.deploy(CustomDealICO);
    deployer.deploy(testICO);
};
