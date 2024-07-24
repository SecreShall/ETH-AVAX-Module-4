// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    struct StoreItem {
        uint256 price;
        string name;
        bool tokenRedeemed;
    }

    StoreItem[] private itemsCatalog; 

    event ItemRedeemed(address indexed user, uint256 itemId, string item);

    constructor() ERC20("Degen", "DGN") {
        // Initialize items
        itemsCatalog.push(StoreItem(10, "Valkyrie", false));
        itemsCatalog.push(StoreItem(20, "Dark Night", false));
        itemsCatalog.push(StoreItem(5, "Shadow of Eminence", false));
        itemsCatalog.push(StoreItem(10, "Demon", false));
        itemsCatalog.push(StoreItem(15, "Vampire", false));
    }

    // Create tokens
    function createTokens(address destination, uint256 amount) public onlyOwner {
        require(destination != address(0), "Invalid address");
        _mint(destination, amount);
    }

    // Transfer Tokens
    function transferTokens(address destination, uint256 amount) public returns (bool) {
        require(destination != address(0), "Invalid recipient");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _transfer(msg.sender, destination, amount);
        return true;
    }

    // Redeem item
    function redeemItem(uint256 itemId) public {
        require(itemId < itemsCatalog.length, "Invalid item ID");
        StoreItem storage item = itemsCatalog[itemId];
        require(balanceOf(msg.sender) >= item.price, "Insufficient balance to redeem item");
        require(!item.tokenRedeemed, "Item already redeemed");

        _burn(msg.sender, item.price);
        item.tokenRedeemed = true;

        emit ItemRedeemed(msg.sender, itemId, item.name);
    }

    // Check balance
    function verifyBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // Burn tokens
    function destroyTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to burn");
        _burn(msg.sender, amount);
    }

    // Get item details
    function getItem(uint256 itemId) public view returns (uint256, string memory, bool) {
        require(itemId < itemsCatalog.length, "Invalid item ID");
        StoreItem memory item = itemsCatalog[itemId];
        return (item.price, item.name, item.tokenRedeemed);
    }


    // List items as a string
    function listStoreItems() external view returns (string memory) {
        string memory storeItems = "";

        for (uint256 i = 0; i < itemsCatalog.length; i++) {
            storeItems = string(abi.encodePacked(storeItems, "[", uintToString(i), "] ", itemsCatalog[i].name, "\n"));
        }

        return storeItems;
    }

    // Utility function to convert uint to string
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
            buffer[digits] = bytes1(uint8(48 + uint8(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

}
