// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract Contracting{

    uint256 public  startDate;
    uint16  public  day;
    uint256 public  amount = 1000;
    uint256 public  deposit = 100;
    address payable employer;
    address payable contractor;
    address judge;

    enum status{notStarted,paid,started,ended,suspended,failed}
    status currentStatus;

    constructor(address payable _employer,address payable _contractor,address _judge,uint16 _day){
        
        employer = _employer;
        contractor = _contractor;
        judge = _judge;
        day = _day;
        currentStatus = status.notStarted;
    }

    function Pay()public payable returns(string memory) {
        
    }

    function Deposit()public payable returns(string memory) {

    }
    
    function Confirm(bool verify)public returns(string memory) {
        
    }

    function Judgement(bool verify)public returns(string memory) {
        
    }

    function WithdrawContractor(bool verify)public payable returns(string memory) {
        
    }

    function WithdrawEmployer(bool verify)public payable returns(string memory) {
        
    }

    
}