pragma solidity ^0.4.11;

import './ERC20Basic.sol';

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {

    /**
     * @dev Check allowance of transfer
     * @param owner The address to transfer to
     * @param spender Address of the spender
     */
    function allowance(address owner, address spender) public constant returns (uint256);

    /**
     * @dev Transfer token from a specified address
     * @param from The address to transfer from
     * @param to The address to transfer to
     * @param value The amount to be transferred
     */
    function transferFrom(address from, address to, uint256 value) public returns (bool);

    /**
     * @dev Approve transfer of funds for a specified address
     * @param spender Address of the spender
     * @param value Amount being send
     */
    function approve(address spender, uint256 value) public returns (bool);

    /**
     * Approval Event
     * @param owner Owner of the amount
     * @param spender Address of the spender
     * @param value The amount being approved
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
