const CustomDealICO = artifacts.require('./CustomDealICO.sol');

module.exports = function (deployer) {
    deployer.deploy(CustomDealICO,
        1528705800,
        1540943995,
        40000,
        '0xa2d79C849b115F23e6615272C474ee695Ee493E8', // Beneficiary address.
        10000000000000000000,
        30000000000000000000000 // 30000 ETH - Hard-cap
    );
};