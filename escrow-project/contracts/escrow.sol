// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
    address public arbiter;
    address public beneficiary;
    address public depositor;
    bool public isApproved;
    mapping(address => uint256) public recieveAddresses;

    constructor(address _arbiter, address _beneficiary) payable {
	arbiter = _arbiter;
	beneficiary = _beneficiary;
	depositor = msg.sender;
    }

    event Approved(uint);
    function approve() external byArbiter {
	uint balance = address(this).balance;
	(bool sent, ) = payable(beneficiary).call{value: balance}("");
 	require(sent, "Failed to send Ether");
	emit Approved(balance);
	isApproved = true;
    }

    event methodApproved(uint);
    function transferIfapproved(uint _amount) external byArbiter { // backup method if above appprove function fail for any reason...
        payable(beneficiary).transfer(_amount);
        emit methodApproved(_amount);
        isApproved = true;

    }

    event PartialPay(uint);
    function approvePartial(uint _amount) external byArbiter {
        payable(beneficiary).transfer(_amount);
        emit PartialPay(_amount);

    }

    event Refund(uint);
    function refundDepositor() external byArbiter { // function to refund depositor incase of dispute...
        uint balance = address(this).balance;
        payable(depositor).transfer(balance);
        emit Refund(balance);
    }

    event Destruct(string);
    function selfDestruct() external byArbiter {
        emit Destruct("self-destruct");
        selfdestruct(payable(arbiter)); // once contracted is deleted, any remaning gas will be transfered to the arbiter..
    }

    modifier byArbiter() {
        require(msg.sender == arbiter);
        _;
    }

    receive() external payable { // adding a fallback function to allow adding extra ether in case of gas related errors.
        recieveAddresses[msg.sender] = msg.value; // saving all addresses(values) to the mapping.
    } 
}
