let CustomDealICO = artifacts.require('./CustomDealICO.sol');

module.exports = function (deployer) {
    const startTime = Math.round((new Date().getTime()) / 1000); // Today
    const endTime = Math.round((new Date().getTime() + (86400000 * 90)) / 1000); // Today + 90 days
    deployer.deploy(CustomDealICO,
        startTime,
        endTime,
        40000,
        '0x1f0C69e1Bc6c8F7d30f163d89De69b88C6A22a30', // Replace this wallet address with the last one (10th account) from Ganache UI. This will be treated as the beneficiary address.
        10000000000000000000000, // 10000 ETH - Soft-cap
        60000000000000000000000 // 60000 ETH - Hard-cap
    );
};