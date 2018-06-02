let CustomDealICO = artifacts.require('./CustomDealICO.sol');

module.exports = function (deployer) {
    const startTime = Math.round((new Date(Date.now() - 86400000).getTime()) / 1000); // Yesterday
    const endTime = Math.round((new Date().getTime() + (86400000 * 20)) / 1000); // Today + 20 days
    deployer.deploy(CustomDealICO,
        startTime,
        endTime,
        43750,
        '0xCB7fA6bac4Fbdc99543Cf06e64330928428dfCd8', // Replace this wallet address with the last one (10th account) from Ganache UI. This will be treated as the beneficiary address.
        10000000000000000000000, // 10000 ETH - Soft-cap
        60000000000000000000000 // 60000 ETH - Hard-cap
    );
};