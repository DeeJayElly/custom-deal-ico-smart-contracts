pragma solidity ^0.4.18;

import './CustomDealToken.sol';
import '../node_modules/zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import '../node_modules/zeppelin-solidity/contracts/crowdsale/RefundableCrowdsale.sol';

/**
 * @title CustomDealICO
 * @author Aleksandar Djordjevic
 * @dev Crowdsale is a base contract for managing a token crowdsale
 * Crowdsales have a start and end timestamps, where investors can make
 * token purchases and the crowdsale will assign them CDL tokens based
 * on a CDL token per ETH rate. Funds collected are forwarded to a wallet
 * as they arrive
 */
contract CustomDealICO is CappedCrowdsale, RefundableCrowdsale {

    // ICO Stages
    // ============
    enum CrowdsaleStage { PreICOFirst, PreICOSecond, ICOFirst, ICOSecond }
    CrowdsaleStage public stage = CrowdsaleStage.PreICOFirst; // By default it's Pre ICO First
    // =============

    // Token Distribution
    // =============================
    uint256 public maxTokens = 400000000000000000000000000; // There will be total 400 000 000 Custom Deal Tokens
    uint256 public tokensForEcosystem = 120000000000000000000000000; // 120 000 000 CDL will be reserved for ecosystem
    uint256 public totalTokensForSale = 280000000000000000000000000; // 280 000 000 CDL will be sold in Crowdsale
    uint256 public totalTokensForSaleDuringPreICO = 100000000000000000000000000; // 100 000 000 CDL will be reserved for PreICO Crowdsale
    // ==============================

    // Amount raised in PreICO
    // ==================
    uint256 public totalWeiRaisedDuringPreICO;
    // ===================

    // Events
    event EthTransferred(string text);
    event EthRefunded(string text);

    // Constructor
    // ============
    function CustomDealICO(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet, uint256 _goal, uint256 _cap) CappedCrowdsale(_cap) FinalizableCrowdsale() RefundableCrowdsale(_goal) Crowdsale(_startTime, _endTime, _rate, _wallet) public {
        require(_goal <= _cap);
    }
    // =============

    // Token Deployment
    // =================
    function createTokenContract() internal returns (MintableToken) {
        return new CustomDealToken(); // Deploys the ERC20 token. Automatically called when crowdsale contract is deployed
    }
    // ==================

    // Crowdsale Stage Management
    // =========================================================

    // Change Crowdsale Stage. Available Options: PreICO, ICO
    function setCrowdsaleStage(uint value) public onlyOwner {

        CrowdsaleStage _stage;

        if (uint(CrowdsaleStage.PreICOFirst) == value) {
            _stage = CrowdsaleStage.PreICOFirst;
        } else if (uint(CrowdsaleStage.PreICOSecond) == value) {
            _stage = CrowdsaleStage.PreICOSecond;
        } else if (uint(CrowdsaleStage.ICOFirst) == value) {
            _stage = CrowdsaleStage.ICOFirst;
        } else if (uint(CrowdsaleStage.ICOSecond) == value) {
            _stage = CrowdsaleStage.ICOSecond;
        }

        stage = _stage;

        if (stage == CrowdsaleStage.PreICOFirst) {
            setCurrentRate(43750);
        } else if (stage == CrowdsaleStage.PreICOSecond) {
            setCurrentRate(38500);
        } else if (stage == CrowdsaleStage.ICOFirst) {
            setCurrentRate(17500);
        } else if (stage == CrowdsaleStage.ICOSecond) {
            setCurrentRate(11666);
        }
    }

    // Change the current rate
    function setCurrentRate(uint256 _rate) private {
        rate = _rate;
    }

    // ================ Stage Management Over =====================

    // Token Purchase
    // =========================
    function () external payable {
        uint256 tokensThatWillBeMintedAfterPurchase = msg.value.mul(rate);

        if ((stage == CrowdsaleStage.PreICOFirst) && (token.totalSupply() + tokensThatWillBeMintedAfterPurchase > totalTokensForSaleDuringPreICO)) {
            msg.sender.transfer(msg.value);
            // Refund them
            EthRefunded("PreICOFirst Limit Hit");
            return;
        }

        if ((stage == CrowdsaleStage.PreICOSecond) && (token.totalSupply() + tokensThatWillBeMintedAfterPurchase > totalTokensForSaleDuringPreICO)) {
            msg.sender.transfer(msg.value); // Refund them
            EthRefunded("PreICOSecond Limit Hit");
            return;
        }

        buyTokens(msg.sender);

        if (stage == CrowdsaleStage.PreICOFirst) {
            totalWeiRaisedDuringPreICO = totalWeiRaisedDuringPreICO.add(msg.value);
        }

        if (stage == CrowdsaleStage.PreICOSecond) {
            totalWeiRaisedDuringPreICO = totalWeiRaisedDuringPreICO.add(msg.value);
        }
    }

    function forwardFunds() internal {
        if (stage == CrowdsaleStage.PreICOFirst || stage == CrowdsaleStage.PreICOSecond) {
            wallet.transfer(msg.value);
            EthTransferred("forwarding funds to wallet");
        } else if (stage == CrowdsaleStage.ICOFirst || stage == CrowdsaleStage.ICOSecond) {
            EthTransferred("forwarding funds to refundable vault");
            super.forwardFunds();
        }
    }
    // ===========================

    // Finish: Mint Extra Tokens as needed before finalizing the Crowdsale.
    // ====================================================================

    function finish(address _ecosystemFund) public onlyOwner {

        require(!isFinalized);
        uint256 alreadyMinted = token.totalSupply();
        require(alreadyMinted < maxTokens);

        uint256 unsoldTokens = totalTokensForSale - alreadyMinted;
        if (unsoldTokens > 0) {
            tokensForEcosystem = tokensForEcosystem + unsoldTokens;
        }

        token.mint(_ecosystemFund,tokensForEcosystem);
        finalize();
    }
    // ===============================
}