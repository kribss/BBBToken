
pragma solidity ^0.6.6;

contract BBBToken{

    address owner;
    address minter;
    address payable jonny;
    address payable aaron;
    address payable owen;
    address payable max;
    address payable mo;
    address payable jesse;
    address payable fredo;
    address payable colin;
    address payable aidan;
    address payable michael;
    string[] public boyz = ["jonny","aaron", "owen","fredo","max", "mo", "jesse", "colin", "aidan", "michael"];


    uint public totalSupply;
    string public constant name = "BillionairesBoyzBlub Membership Token";
    string public constant symbol = "BBB";
    uint8 public constant decimals = 18;
    uint8 public constant mintCap = 1;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

   mapping(address => uint) public balanceOf;
   mapping(address=> mapping(address=>uint)) public allowance;

    constructor(uint _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        owner = msg.sender;
        minter = msg.sender;
        totalSupply = _initialSupply;
    }

    function changeMinter(address _minter) external {
        require(msg.sender == minter, "Only current minter can change minter address!");
        minter = _minter;
    }

    function mintNewMember(address _newMemberAddress, string memory _newMemberName) public {
        require(msg.sender == minter, "Only minter can mint!");
        totalSupply = totalSupply+mintCap;
        balanceOf[_newMemberAddress] = mintCap;
        boyz.push(_newMemberName);

    }
    function transfer(address _to, uint _value) public returns (bool success){
        require(balanceOf[msg.sender] >= _value, "You do not have the required tokens!");
        /*below ensures that only those with no bbb token can recieve one, therefore implementing a cap of 1 token per person*/
        require(balanceOf[_to] == 0, "Sorry, but but the account you're trying to send to is already a member.");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function approve(address _spender, uint _value) public returns  (bool success){

        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) public {
        require(balanceOf[_from] >= _value);
        require(allowance[_from][msg.sender] >= _value);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from,_to,_value);
    }
}