// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "IERC20.sol";
import "Ownable.sol";

contract CliamFD is  Ownable {

    //代币地址
    address public token_address;
    uint256 public last_date;
    uint256 public tax_fees;
    address public admin_address;
    uint256 private admin_fees;
    uint256 public total_claim;
    uint256 private max_claim;
    address public tax_account;

    mapping(address => uint256) private claimUser;

    event claimUnit(address claim_address, uint256 amount);
    event burnToken(uint256 amount);

    constructor(address _token_add)  {
        token_address = _token_add;
        last_date = 1649433600; //April 9, 2022 12:00:00 AM
        tax_fees = 20000000; // 20 trx tax
        admin_fees = 10000000; // 10 trx tax
        tax_account = 0xAbbc29798A3f33322B42598249aE85d68B019FcE; //TRdFxb3JrcRKQCncYTfAnsVoDLHpT94WzF
        total_claim = 0;
        max_claim = 10000000000;
        admin_address = msg.sender;
    }

    // 用户能领
    function ClaimUser(address user_address, uint256 amount) external onlyOwner returns(bool){
        require(block.timestamp <= last_date, 'Claim already expired');
        require(amount <= max_claim, 'Suspicous Claim');
        require(claimUser[user_address] <= 0, 'This address already claim');

        IERC20(token_address).transfer(user_address, amount);

        claimUser[user_address] = 1;
        total_claim += amount;
        emit claimUnit(user_address, amount);
        return true;
    }
    
    // 税收
    function payTax()payable external returns(bool){
        uint256 total_need = tax_fees + admin_fees;
        require(block.timestamp <= last_date, 'Claim already expired');
        require(claimUser[msg.sender] <= 0, 'This address already claim');
        require(msg.value >= total_need, 'Not enough Tax fees');

        payable(tax_account).transfer(tax_fees);
        payable(admin_address).transfer(admin_fees);

        return true;
    }

    // 燃烧代币
    function BurnAll () external onlyOwner returns(bool){
        require(block.timestamp >= last_date, 'Claim have not expired');
        uint256 amt_left = IERC20(token_address).balanceOf(address(this));

        IERC20(token_address).burn(amt_left);
        emit burnToken(amt_left);
        return true;
    }

    // 替换admin Fees
    function SetAdmin (address _admin) external onlyOwner returns(bool){
        admin_address = _admin;
        return true;
    }
}
