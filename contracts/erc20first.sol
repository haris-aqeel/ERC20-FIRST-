// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IERC20 {
    


    // Returns the amount of tokens owned by an account
    function balanceOf(address account) external view returns (uint); 

    // Spender is allowed to use tokens in place of owner. Returns the number of token spender is entitled to use
    function allowance(address owner, address spender) external view returns(uint);

    // Transfer amount of token from msg.sender account to recepient account
    function transfer(address recepient, uint256 amountOfTokens) external returns(bool);

    // Number Of Tokens Approved By OWNER
    function approve(address spender, uint256 amountOfTokens) external returns (bool);


    // Number of Tokens which sender allowed which can be transferred
    function transferFrom(address sender, address recepient, uint amountOfTokens) external returns(bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    // amount of tokens (value) is approved by the owner to be used by the spender.
    event Approval(address indexed owner, address indexed spender, uint256 value);


}


contract ERC20Contract is IERC20{
    
    uint256 public totalSupply;
    string public name;
    string public symbol;
    uint256 public decimals = 0;

    mapping(address => uint256) balance;
    mapping(address => mapping(address => uint256)) allowed;

    constructor(uint256 _totalSupply, string memory _name, string memory _symbol){
        totalSupply = _totalSupply;
        balance[msg.sender] = _totalSupply;
        name = _name;
        symbol = _symbol;
    }

    function balanceOf(address owner) public override view returns(uint256){
        return balance[owner];
    }

    function transfer(address recepient, uint256 amountOfTokens) public override returns(bool) {
        require(amountOfTokens <= balance[msg.sender]);
        balance[msg.sender] = balance[msg.sender] - amountOfTokens;
        balance[recepient] = balance[recepient] + amountOfTokens;
        emit Transfer(msg.sender, recepient, amountOfTokens);
        return true;
    }

    function allowance(address owner, address recepient) public override view returns(uint256) {
        return allowed[owner][recepient];
    } 


    function approve(address spender, uint256 amountOfTokens) public override returns(bool){
        allowed[msg.sender][spender] = amountOfTokens;
        emit Approval(msg.sender, spender, amountOfTokens);
        return true;
    }

    function transferFrom(address owner, address recepient, uint256 amountOfTokens) public override returns(bool) {
        require(amountOfTokens <= balance[owner]);
        require(amountOfTokens <= allowed[owner][msg.sender]);

        balance[owner] = balance[owner] - amountOfTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - amountOfTokens;
        balance[recepient] = balance[recepient] + amountOfTokens;
        emit Transfer(owner, recepient, amountOfTokens);
        return true;
    }



}