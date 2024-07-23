// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract DegenToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address public owner;

    struct StoreItem {
        uint price;
        string name;
        bool tokenRedeemed;
    }

    StoreItem[] private items;

    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        name = "Degen";
        symbol = "DGN";
        decimals = 18;
        totalSupply = 1_000_000 * 10**uint256(decimals);
        owner = msg.sender;
        balanceOf[owner] = totalSupply;

        // Initialize store items
        items.push(StoreItem(100, "Void Crystal", false));
        items.push(StoreItem(50, "Quantum Core", false));
        items.push(StoreItem(200, "Stellar Essence", false));
        items.push(StoreItem(100, "Nebula Shard", false));
        items.push(StoreItem(150, "Cosmic Dust", false));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Invalid recipient");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        require(spender != address(0), "Invalid spender");
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(from != address(0), "Invalid sender");
        require(to != address(0), "Invalid recipient");
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function mint(address account, uint256 amount) external onlyOwner {
        require(account != address(0), "Invalid account");
        totalSupply += amount;
        balanceOf[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function burn(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        totalSupply -= amount;
        balanceOf[msg.sender] -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function listStoreItems() external view returns (string memory) {
        string memory storeItems = "";

        for (uint256 i = 0; i < items.length; i++) {
            storeItems = string(abi.encodePacked(storeItems, "   [", uintToString(i), "] ", items[i].name, "\n"));
        }

        return storeItems;
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function uintToString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + value % 10));
            value /= 10;
        }
        return string(buffer);
    }
}
