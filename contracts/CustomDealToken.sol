pragma solidity ^0.4.11;

import './token/MintableToken.sol';

contract CustomDealToken is MintableToken {
    string public constant name = "Custom Deal Token";
    string public constant symbol = "CDL";
    uint256 public constant decimals = 18;
    uint256 public constant _totalSupply = 400000000 * 1 ether;

    /** Constructor CustomDealToken */
    function CustomDealToken() {
        totalSupply = _totalSupply;
    }
}


