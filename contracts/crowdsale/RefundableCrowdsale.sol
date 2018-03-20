pragma solidity ^0.4.11;

import '../SafeMath.sol';
import './FinalizableCrowdsale.sol';
import './RefundVault.sol';

/**
 * @title RefundableCrowdsale
 * @dev Extension of Crowdsale contract that adds a funding goal, and
 * the possibility of users getting a refund if goal is not met.
 * Uses a RefundVault as the crowdsale's vault.
 */
contract RefundableCrowdsale is FinalizableCrowdsale {

    // Using SafeMath library for math operations
    using SafeMath for uint256;

    // Minimum amount of funds to be raised in weis
    uint256 public goal;

    // If the goal is reached or not
    bool private _goalReached = false;

    // Refund vault used to hold funds while crowdsale is running
    RefundVault private vault;

    /**
     * @dev RefundableCrowdsale Constructor
     */
    function RefundableCrowdsale(uint256 _goal) public {
        require(_goal > 0);
        vault = new RefundVault(wallet);
        goal = _goal;
    }

    /**
     * @dev We're overriding the fund forwarding from Crowdsale.
     * In addition to sending the funds, we want to call
     * the RefundVault deposit function
     */
    function forwardFunds() internal {
        vault.deposit.value(msg.value)(msg.sender);
    }

    /**
     * @dev If crowdsale is unsuccessful, investors can claim refunds here
     */
    function claimRefund() public {
        require(isFinalized);
        require(!goalReached());

        vault.refund(msg.sender);
    }

    /**
     * @dev Vault finalization task, called when owner calls finalize()
     */
    function finalization() internal {
        if (goalReached()) {
            vault.close();
        } else {
            vault.enableRefunds();
        }
        super.finalization();
    }

    /**
     * @dev Goal reached function called to check if the cap goal is reached
     * @return true if the goal is reached, false if it's not
     */
    function goalReached() public payable returns (bool) {
        if (weiRaised >= goal) {
            _goalReached = true;
            return true;
        } else if (_goalReached) {
            return true;
        }
        else {
            return false;
        }
    }

    /**
     * @dev If the cap goal is reached then updated the _goalReached
     */
    function updateGoalCheck() onlyOwner public {
        _goalReached = true;
    }

    /**
     * @dev Get vault address
     * @return vault address
     */
    function getVaultAddress() onlyOwner public view returns (address) {
        return vault;
    }
}