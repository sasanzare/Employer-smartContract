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

        require(currentStatus==status.notStarted);
        require(msg.sender==employer);
        require(msg.value==amount);
        startDate = block.timestamp;
        currentStatus = status.paid;
        return "Payment was made by the employer.";

    }

    function Deposit()public payable returns(string memory) {

        require(msg.sender==employer);
        require(msg.value==deposit);
        require(currentStatus == status.paid);
        currentStatus = status.started;
        return "The guarantee amount was paid.";
    }
    
    function Confirm(bool verify)public returns(string memory) {

        require(msg.sender==employer);
        require(currentStatus == status.started);
        if(verify){
            currentStatus = status.ended;
            return "The project is over."; 
        }else{
            if(block.timestamp>(day*84600)+startDate){
                currentStatus= status.suspended;
                return "Deadline is over."; 
            }else{
               return "Deadline is not over."; 
            }
        }
    }

    function Judgement(bool verify)public returns(string memory) {

        require(currentStatus== status.suspended);
        require(msg.sender==judge);
        if(verify){
            currentStatus = status.ended;
            return "The project was ended.";
        }else{
            currentStatus = status.failed;
            return "The project was failed.";
        }
    }

    function WithdrawContractor()public payable returns(string memory) {

        require(msg.sender== contractor);
        require(currentStatus == status.ended);
        contractor.transfer(1100);
        return "The contractor withdrew his salary.";
    }

    function WithdrawEmployer()public payable returns(string memory) {
        
        require(msg.sender== employer);
        require(currentStatus == status.failed);
        contractor.transfer(1100);
        return "The original money and losses were withdrawn.";
    }

    
}