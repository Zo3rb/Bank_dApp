// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Bank {
    // Bank Information.
    address public bankOwner;
    string public bankName;

    // Customer Balance.
    mapping(address => uint) public customerBalance;

    // Function to be Invoked Once The Contract Deploys.
    constructor() {
        // Set the Ownership of the Bank to The Deployer.
        bankOwner = msg.sender;
    }

    // Declare a Function to Set the Bank name.
    function setBankName(string memory _newBankName) external {
        require(msg.sender == bankOwner, "You need to be the Bank's Owner to be Able to change it's Name");
        bankName = _newBankName;
    }

    // Declare a Function to get The Bank's Balance.
    function getBankBalance() external view returns(uint) {
        require(msg.sender == bankOwner, "You need to be The Bank's Owner to check it's Balance");
        return address(this).balance;
    }

    // Declare a Function to get The Customer's Balance.
    function getCustomerBalance() public view returns(uint) {
        return customerBalance[msg.sender];
    }
    

    // Declare a Function to Deposit Money into Customer's Account.
    function depositMoney() public payable {
        require(msg.value != 0, "You Can't Deposit 0 Value in Your Account");
        customerBalance[msg.sender] += msg.value;
    }

    // Declare a Function to Withdraw Money From Customer's Account.
    function witdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= customerBalance[msg.sender], "Your Account Must Cover the Amount You need to Withdraw");
        customerBalance[msg.sender] -= _amount;
        _to.transfer(_amount);
    } 

}