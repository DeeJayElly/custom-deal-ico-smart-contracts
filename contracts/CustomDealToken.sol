pragma solidity ^0.4.11;

import './token/MintableToken.sol';

/**
 * @title CustomDealToken
 * @author Aleksandar Djordjevic
 * @dev Custom Deal Mintable Token is a base contract for managing a token contract
 */
contract CustomDealToken is MintableToken {

    // Name of the token
    string public constant name = 'Custom Deal Token';

    // Symbol of the token
    string public constant symbol = 'CDL';

    // Number of decimal places of the token
    uint256 public constant decimals = 18;

    // Total supply amount
    uint256 public constant _totalSupply = 400000000 * 1 ether;

    /**
     * @title CustomDealToken
     * @dev CustomDealToken Constructor
     */
    function CustomDealToken() {
        totalSupply = _totalSupply;
    }
}


