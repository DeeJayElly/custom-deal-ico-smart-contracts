let CustomDealICO = artifacts.require('./CustomDealICO.sol');

module.exports = function (deployer) {
    const startTime = Math.round((new Date().getTime()) / 1000); // Today
    const endTime = Math.round((new Date().getTime() + (86400000 * 90)) / 1000); // Today + 90 days
    deployer.deploy(CustomDealICO,
        startTime,
        endTime,
        40000,
        '0xa2d79C849b115F23e6615272C474ee695Ee493E8', // Replace this wallet address with the last one (10th account) from Ganache UI. This will be treated as the beneficiary address.
        10000000000000000000, // 10 ETH - Soft-cap
        30000000000000000000000 // 30000 ETH - Hard-cap
    );
};