pragma solidity ^0.4.11;

import '../SafeMath.sol';
import '../Ownable.sol';

/**
 * @title RefundVault
 * @dev This contract is used for storing funds while a crowdsale
 * is in progress. Supports refunding the money if crowdsale fails,
 * and forwarding it if crowdsale is successful.
 */
contract RefundVault is Ownable {

    // Using SafeMath library for math operations
    using SafeMath for uint256;

    // State of the refund - active, refunding, closed
    enum State {Active, Refunding, Closed}

    // Deposited addresses
    mapping(address => uint256) public deposited;

    // Wallet address
    address public wallet;

    // State value
    State public state;

    // Closed Event fired when the refund is closed
    event Closed();

    // RefundsEnabled Event fired when the refunds become available
    event RefundsEnabled();

    // Refunded Event fired when the refund is completed
    event Refunded(address indexed beneficiary, uint256 weiAmount);

    /**
     * @title RefundVault
     * @dev RefundVault Constructor
     */
    function RefundVault(address _wallet) {
        require(_wallet != 0x0);
        wallet = _wallet;
        state = State.Active;
    }

    /**
     * @title deposit
     * @dev Deposit funds in the deposited vault
     */
    function deposit(address investor) onlyOwner public payable {
        require(state == State.Active);
        deposited[investor] = deposited[investor].add(msg.value);
    }

    /**
     * @title close
     * @dev Close the refund functionality
     */
    function close() onlyOwner public {
        require(state == State.Active);
        state = State.Closed;
        Closed();
        wallet.transfer(this.balance);
    }

    /**
     * @title enableRefunds
     * @dev Enable refunds functionality
     */
    function enableRefunds() onlyOwner public {
        require(state == State.Active);
        state = State.Refunding;
        RefundsEnabled();
    }

    /**
     * @title refund
     * @dev Refund funds to investors address
     */
    function refund(address investor) public {
        require(state == State.Refunding);
        uint256 depositedValue = deposited[investor];
        deposited[investor] = 0;
        investor.transfer(depositedValue);
        Refunded(investor, depositedValue);
    }
}
