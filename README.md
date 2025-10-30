<img width="1919" height="974" alt="image" src="https://github.com/user-attachments/assets/f09e1e13-12d3-473f-8c94-d0cc6b38f1d3" />
# 🔢 SimpleCounter Smart Contract

A beginner-friendly Solidity smart contract deployed on the Celo Alfajores testnet. This project demonstrates the basics of blockchain development with a simple counter that anyone can increment.

## 📖 Project Description

SimpleCounter is a minimal smart contract built with Solidity that serves as an excellent starting point for learning blockchain development. It showcases fundamental concepts like state variables, functions, events, and contract deployment without any complex logic or input parameters.

## 🎯 What It Does

This smart contract maintains a counter on the blockchain that:
- Starts at 0 when deployed
- Can be incremented by anyone calling the `increment()` function
- Stores the count permanently on the blockchain
- Emits events whenever the count changes
- Allows anyone to view the current count at any time

## ✨ Features

- **🚀 Zero Configuration** - No input fields or parameters needed
- **📊 Public Counter** - Transparent count visible to everyone
- **⛽ Gas Efficient** - Minimal operations for low transaction costs
- **📢 Event Logging** - Emits `CountIncreased` event for tracking
- **🔓 Open Access** - Anyone can increment the counter
- **👀 Read Functions** - View current count without gas fees
- **🎓 Beginner Friendly** - Clean, well-commented code for learning

## 🔗 Deployed Smart Contract

**Contract Address:** 0xd9145CCE52D386f254917e481eB44e9943F39138

**Network:** Celo Alfajores Testnet

**Block Explorer:** [View on Blockscout](https://celo-alfajores.blockscout.com/address/0xd9145CCE52D386f254917e481eB44e9943F39138)

## 💻 Smart Contract Code

```solidity
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
```

## 🛠️ How to Use

### Interact with the Contract

1. **View Current Count**
   - Call the `count` variable or `getCount()` function
   - No gas fees required (read-only)

2. **Increment the Counter**
   - Call the `increment()` function
   - Requires a small amount of gas
   - Count increases by 1

### Deploy Your Own

1. Go to [Remix IDE](https://remix.ethereum.org)
2. Create a new file `SimpleCounter.sol`
3. Paste the contract code
4. Compile with Solidity 0.8.0 or higher
5. Deploy to your preferred network

## 🌐 Network Information

- **Network:** Celo Alfajores Testnet
- **Chain ID:** 44787
- **Currency:** CELO (testnet)
- **RPC URL:** https://alfajores-forno.celo-testnet.org

## 📚 Learning Resources

This contract demonstrates:
- State variables (`uint256 public count`)
- Constructor functions
- Public functions (`increment()`, `getCount()`)
- Events (`CountIncreased`)
- View functions (read-only operations)

## 🤝 Contributing

This is a learning project! Feel free to:
- Fork the repository
- Experiment with the code
- Add new features
- Share your improvements

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

Built as a beginner-friendly introduction to Solidity and smart contract development.

---

⭐ **Star this repo if you found it helpful!**
