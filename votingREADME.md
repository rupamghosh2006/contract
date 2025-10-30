<img width="1919" height="966" alt="image" src="https://github.com/user-attachments/assets/73abf5e8-2397-4ce6-8687-0ff7b8e15db7" />
# 🗳️ Decentralized Voting Smart Contract

A secure and transparent blockchain-based voting system built with Solidity and deployed on the Celo Alfajores testnet. This smart contract enables democratic voting with complete transparency and immutability.

## 📖 Project Description

This Voting smart contract provides a complete decentralized voting solution where an admin can register candidates and voters, manage voting sessions, and ensure each registered voter can cast only one vote. All votes are permanently recorded on the blockchain, making the process transparent and tamper-proof.

## 🎯 What It Does

This smart contract creates a fully functional voting system that:
- Allows an admin to add candidates before voting starts
- Enables voter registration by the admin
- Opens and closes voting sessions with admin control
- Ensures each registered voter can vote only once
- Records all votes permanently on the blockchain
- Provides transparent vote counting after voting ends
- Emits events for every major action for complete auditability

## ✨ Features

### 👨‍💼 Admin Functions
- **🎭 Add Candidates** - Register candidates before voting begins
- **📝 Register Voters** - Whitelist eligible voters
- **▶️ Start Voting** - Open the voting session (requires 2+ candidates)
- **⏹️ End Voting** - Close the voting session and finalize results

### 🗳️ Voter Functions
- **✅ Cast Vote** - Registered voters can vote for their chosen candidate
- **🔒 One Vote Only** - Prevents double voting automatically
- **👀 View Candidates** - Anyone can see candidate information
- **📊 View Results** - Check vote counts after voting ends

### 🛡️ Security Features
- **🔐 Access Control** - Admin-only functions protected by modifiers
- **✔️ Registration Check** - Only registered voters can participate
- **🚫 Anti-Double Voting** - Built-in prevention mechanism
- **⏰ Session Management** - Voting restricted to active sessions
- **📢 Event Logging** - Complete audit trail of all actions

## 🔗 Deployed Smart Contract

**Contract Address:** `https://celo-alfajores.blockscout.com/address/0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3`

**Network:** Celo Alfajores Testnet

**Block Explorer:** [View on Blockscout](https://celo-alfajores.blockscout.com/address/0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3)

## 💻 Smart Contract Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Voting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }
    
    struct Voter {
        bool registered;
        bool hasVoted;
        uint256 votedCandidateId;
    }
    
    address public admin;
    bool public votingOpen;
    uint256 public candidateCount;
    
    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voter) public voters;
    
    event CandidateAdded(uint256 candidateId, string name);
    event VoterRegistered(address voter);
    event VoteCast(address voter, uint256 candidateId);
    event VotingStarted();
    event VotingEnded();
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }
    
    modifier onlyDuringVoting() {
        require(votingOpen, "Voting is not open.");
        _;
    }
    
    constructor() {
        admin = msg.sender;
        votingOpen = false;
    }
    
    // Admin function to add a candidate
    function addCandidate(string memory _name) external onlyAdmin {
        require(!votingOpen, "Cannot add candidates during voting.");
        candidateCount++;
        candidates[candidateCount] = Candidate(_name, 0);
        emit CandidateAdded(candidateCount, _name);
    }
    
    // Register a voter
    function registerVoter(address _voter) external onlyAdmin {
        require(!voters[_voter].registered, "Voter is already registered.");
        voters[_voter] = Voter(true, false, 0);
        emit VoterRegistered(_voter);
    }
    
    // Start voting session
    function startVoting() external onlyAdmin {
        require(candidateCount > 1, "At least two candidates required to start voting.");
        require(!votingOpen, "Voting is already open.");
        votingOpen = true;
        emit VotingStarted();
    }
    
    // End voting session
    function endVoting() external onlyAdmin {
        require(votingOpen, "Voting is not currently open.");
        votingOpen = false;
        emit VotingEnded();
    }
    
    // Voter casts their vote
    function vote(uint256 _candidateId) external onlyDuringVoting {
        Voter storage sender = voters[msg.sender];
        require(sender.registered, "You are not a registered voter.");
        require(!sender.hasVoted, "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate ID.");
        
        sender.hasVoted = true;
        sender.votedCandidateId = _candidateId;
        candidates[_candidateId].voteCount++;
        
        emit VoteCast(msg.sender, _candidateId);
    }
    
    // Get candidate details
    function getCandidate(uint256 _candidateId) external view returns (string memory name, uint256 voteCount) {
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate ID.");
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.name, candidate.voteCount);
    }
    
    // Get total votes for a specific candidate
    function getTotalVotes(uint256 _candidateId) external view returns (uint256) {
        require(!votingOpen, "Voting is still in progress.");
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate ID.");
        return candidates[_candidateId].voteCount;
    }
}
```

## 🛠️ How to Use

### For Admin

1. **Deploy the Contract**
   - You become the admin automatically upon deployment

2. **Add Candidates**
   ```solidity
   addCandidate("Alice")
   addCandidate("Bob")
   ```

3. **Register Voters**
   ```solidity
   registerVoter(0x123...abc)
   ```

4. **Start Voting**
   ```solidity
   startVoting()
   ```

5. **End Voting**
   ```solidity
   endVoting()
   ```

### For Voters

1. **Check Registration**
   - Verify you're registered before voting starts

2. **Cast Your Vote**
   ```solidity
   vote(1) // Vote for candidate ID 1
   ```

3. **View Results** (after voting ends)
   ```solidity
   getTotalVotes(1)
   getCandidate(1)
   ```

## 📊 Contract Functions

### Admin Functions
| Function | Description | Parameters |
|----------|-------------|------------|
| `addCandidate` | Add a new candidate | `_name` (string) |
| `registerVoter` | Register eligible voter | `_voter` (address) |
| `startVoting` | Open voting session | None |
| `endVoting` | Close voting session | None |

### Public Functions
| Function | Description | Parameters | Access |
|----------|-------------|------------|--------|
| `vote` | Cast a vote | `_candidateId` (uint256) | Registered voters only |
| `getCandidate` | View candidate info | `_candidateId` (uint256) | Anyone |
| `getTotalVotes` | Get vote count | `_candidateId` (uint256) | Anyone (after voting) |

### View Functions
| Function | Returns |
|----------|---------|
| `admin` | Admin address |
| `votingOpen` | Voting status (bool) |
| `candidateCount` | Total candidates |
| `candidates` | Candidate details by ID |
| `voters` | Voter details by address |

## 🔄 Workflow

```
1. Deploy Contract → Admin is set
2. Add Candidates → Register 2+ candidates
3. Register Voters → Whitelist eligible addresses
4. Start Voting → Open voting session
5. Voters Cast Votes → Each voter votes once
6. End Voting → Close session
7. View Results → Check vote counts
```

## 🌐 Network Information

- **Network:** Celo Alfajores Testnet
- **Chain ID:** 44787
- **Currency:** CELO (testnet)
- **RPC URL:** https://alfajores-forno.celo-testnet.org
- **Explorer:** https://celo-alfajores.blockscout.com

## 📚 Technical Details

### Data Structures
- **Candidate:** Stores name and vote count
- **Voter:** Tracks registration, voting status, and vote choice

### Security Modifiers
- `onlyAdmin`: Restricts functions to admin only
- `onlyDuringVoting`: Ensures voting is active

### Events
- `CandidateAdded`: Fired when candidate is added
- `VoterRegistered`: Fired when voter is registered
- `VoteCast`: Fired when vote is cast
- `VotingStarted`: Fired when voting begins
- `VotingEnded`: Fired when voting closes

## 🎓 Learning Objectives

This contract demonstrates:
- **Structs** for complex data structures
- **Mappings** for efficient data storage
- **Modifiers** for access control
- **Events** for transaction logging
- **State management** with boolean flags
- **Role-based permissions** (admin vs voters)
- **Input validation** and error handling

## 🚀 Deployment Guide

1. Open [Remix IDE](https://remix.ethereum.org)
2. Create `Voting.sol` and paste the code
3. Compile with Solidity 0.8.26
4. Deploy to Celo Alfajores testnet
5. Get testnet CELO from [faucet](https://faucet.celo.org)

## ⚠️ Important Notes

- Only the deployer becomes the admin
- Candidates must be added before starting voting
- Minimum 2 candidates required to start
- Vote counts are visible only after voting ends
- All actions are permanent and immutable

## 🤝 Contributing

Contributions are welcome! Possible improvements:
- Add candidate removal functionality
- Implement vote delegation
- Add time-based voting periods
- Create a frontend interface
- Add voting power weights

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

Built as a demonstration of blockchain-based governance and transparent voting systems using Solidity smart contracts.

---

⭐ **Star this repo if you believe in transparent democracy!**

💡 **Perfect for:** DAOs, community voting, elections, polls, governance systems
