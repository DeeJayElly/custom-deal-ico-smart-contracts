let CustomDealICO = artifacts.require('./CustomDealICO.sol');

module.exports = function (deployer) {
    deployer.deploy(CustomDealICO,
        1528705800,
        1535846340,
        40000,
        '0xa2d79C849b115F23e6615272C474ee695Ee493E8', // Replace this wallet address with the last one (10th account) from Ganache UI. This will be treated as the beneficiary address.
        10000000000000000000,
        30000000000000000000000 // 30000 ETH - Hard-cap
    );
};