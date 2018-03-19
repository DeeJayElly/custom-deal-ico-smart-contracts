pragma solidity ^0.4.11;

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {

    // Total supply of tokens
    uint256 public totalSupply;

    /**
     * @title balanceOf
     * @dev Get balance of the specified account address
     * @param who Address of the account
     */
    function balanceOf(address who) public constant returns (uint256);

    /**
     * @title transfer
     * @dev Approve transfer of funds for a specified address
     * @param to The address where the amount is being sent to
     * @param value Amount being send
     */
    function transfer(address to, uint256 value) public returns (bool);

    /**
     * Transfer Event
     * @dev Event being fired after the transfer of funds occurs
     * @param to The address where the amount is being sent to
     * @param value Amount being send
     */
    event Transfer(address indexed from, address indexed to, uint256 value);
}
