<h1 align="center">ETH + AVAX PROOF: Intermediate EVM Course</h1>
<h1 align="center">Building on Avalanche - ETH + AVAX</h1>

# DegenToken Smart Contract

## Overview

`DegenToken` is an ERC20-based smart contract that extends the standard functionality with additional features. It allows for the creation, transfer, and burning of tokens, as well as redeeming items from a catalog. 

## Features

- **ERC20 Token**: Implements the standard ERC20 interface with minting and burning capabilities.
- **Item Redemption**: Users can redeem items from a catalog using tokens.
- **Catalog Management**: A catalog of items with details such as price and name.
- **Balance Checking**: Allows users to verify their token balance.

## Contract Details

- **Token Name**: Degen
- **Token Symbol**: DGN

### Catalog Items

1. Valkyrie - 10 DGN
2. Dark Night - 20 DGN
3. Shadow of Eminence - 5 DGN
4. Demon - 10 DGN
5. Vampire - 15 DGN

# Contract Functions

## `createTokens(address destination, uint256 amount)`
**Description:** Creates and mints new tokens, assigning them to the specified address.  
**Parameters:**
- `destination`: The address to which the tokens will be minted.
- `amount`: The number of tokens to be created.  
**Access Control:** Only callable by the contract owner.  
**Usage:** Useful for distributing tokens to users or addresses as required.

## `transferTokens(address destination, uint256 amount)`
**Description:** Transfers tokens from the sender’s address to the specified destination address.  
**Parameters:**
- `destination`: The address to which tokens will be transferred.
- `amount`: The number of tokens to transfer.  
**Returns:** `true` if the transfer is successful.  
**Usage:** Allows users to send tokens to other addresses.

## `redeemItem(uint256 itemId)`
**Description:** Allows users to redeem an item from the catalog by burning the equivalent amount of tokens.  
**Parameters:**
- `itemId`: The ID of the item to be redeemed.  
**Events:** Emits an `ItemRedeemed` event with details about the redeemed item.  
**Usage:** Users can redeem items using their token balance. The item is marked as redeemed once the transaction is successful.

## `destroyTokens(uint256 amount)`
**Description:** Burns a specified amount of tokens from the caller’s balance.  
**Parameters:**
- `amount`: The number of tokens to burn.  
**Usage:** Allows users to destroy their tokens, reducing their total supply.

## `getItem(uint256 itemId)`
**Description:** Retrieves details about a specific item from the catalog.  
**Parameters:**
- `itemId`: The ID of the item to retrieve.  
**Returns:**
- `price`: The price of the item in tokens.
- `name`: The name of the item.
- `tokenRedeemed`: A boolean indicating whether the item has already been redeemed.  
**Usage:** Provides information about items in the catalog.

## `listStoreItems()`
**Description:** Lists all items in the catalog with their IDs and names as a string.  
**Returns:** A string representing the catalog of items.  
**Usage:** Useful for displaying a list of available items to users.

## `verifyBalance(address account)`
**Description:** Checks the token balance of the specified address.  
**Parameters:**
- `account`: The address whose balance is to be checked.  
**Returns:** The token balance of the specified address.  
**Usage:** Allows users to verify their token balance or check the balance of any address.

# Security Considerations
- Ensure that the `onlyOwner` modifier is used appropriately to restrict access to sensitive functions.
- Always test your contract thoroughly on test networks before deploying to the mainnet.

# Setting Up the Project

1. **Clone the Repository:**  
   Use GitHub Desktop or your terminal to clone this repository to your local device.

2. **Open Terminal:**  
   Navigate to the project's root directory in your terminal.

3. **Install Dependencies:**  
   Run `npm install` in the terminal and wait for the installation to complete.

4. **Start Remixd:**  
   In the same terminal, execute `remixd`.

5. **Access Remix IDE:**  
   Open your web browser and go to [Remix IDE](https://remix.ethereum.org).

6. **Connect to Localhost:**  
   In Remix, go to the File Explorer tab. Under "Workspaces," select "Connect to localhost" and click "Connect."

# Deploying the Project

1. **Open Remix IDE:**  
   Navigate to [Remix IDE](https://remix.ethereum.org) if it's not already open.

2. **Compile the Contract:**  
   Go to the Solidity Compiler tab and click "Compile DegenToken.sol."

3. **Deploy the Contract:**  
   Switch to the Deploy and Run Transactions tab. Select "Injected Provider - MetaMask" under "Environment."

4. **Verify MetaMask Connection:**  
   Ensure MetaMask is connected to the Avalanche Fuji Testnet.

5. **Deploy:**  
   Click the "Deploy" button to deploy the contract.

## Authors

Contributors names and contact info

- Clint Audrey Dela Cruz
- Github: SecreShall


# License
This project is licensed under the MIT License.
