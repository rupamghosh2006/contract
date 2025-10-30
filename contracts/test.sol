// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleCounter
 * @dev A basic smart contract that counts up automatically
 */
contract SimpleCounter {
    // State variable to store the count
    uint256 public count;
    
    // Event emitted when count increases
    event CountIncreased(uint256 newCount);
    
    // Constructor - runs once when contract is deployed
    constructor() {
        count = 0;
    }
    
    // Function to increment the counter by 1
    function increment() public {
        count = count + 1;
        emit CountIncreased(count);
    }
    
    // Function to get the current count (already public, but showing as example)
    function getCount() public view returns (uint256) {
        return count;
    }
}
