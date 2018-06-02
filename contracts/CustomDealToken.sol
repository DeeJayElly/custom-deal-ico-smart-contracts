pragma solidity ^0.4.18;

import '../node_modules/zeppelin-solidity/contracts/token/MintableToken.sol';

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
}

