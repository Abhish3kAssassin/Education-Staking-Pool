# Education-Staking-Pool
Overview
The Education Staking Pool is a decentralized application (DApp) that allows users to stake their tokens to fund various educational projects. In return for their contributions, users can earn rewards at a rate of 0.1%. This contract acts as a vehicle to pool funds in support of educational initiatives while providing users with a monetary incentive.

Features
Staking: Users can stake their ERC20 tokens in the pool to fund pending educational projects.
Unstaking: Users are permitted to withdraw their staked tokens at any time.
Rewards: For every block, users earn a reward based on the amount they have staked.
User Info: Users can retrieve their staking and rewards information.
How It Works
Staking Tokens:

Users call the stake() function with the amount of tokens they wish to stake.
Tokens are transferred from the user's wallet to the contract, and their staked amount is recorded.
Unstaking Tokens:

Users can call the unstake() method to withdraw their tokens.
The contract checks the user’s staked amount and performs the transfer.
Claiming Rewards:

By calling claimRewards(), users can withdraw accumulated rewards based on their stakes.
Rewards are calculated based on the time the tokens have been staked multiplied by the reward rate.
User Information:

The getUserInfo() function allows users to check their staked balance and potential rewards.
Technical Specifications
Token Standard: ERC20, which must be compliant with the ERC20 interface for transfers.
Reward Calculation: Rewards are accrued linearly over time, and are released upon claiming.

## Flowchart

graph TD;
    A[Start] --> B[User Stake Tokens];
    B --> C[Update Rewards];
    C --> D[Store Stake Info];
    D --> E[Emit Staked Event];
    E --> F{User Wants to Unstake?};
    F -- Yes --> G[Update Rewards];
    G --> H[Unstake Tokens];
    H --> I[Emit Unstaked Event];
    I --> J{User Wants to Claim Rewards?};
    F -- No --> J;
    J -- Yes --> K[Update Rewards];
    K --> L[Claim Rewards];
    L --> M[Emit Rewards Claimed Event];
    J -- No --> N[End];
Benefits
This platform fosters a community-driven approach to funding educational projects.
Users are incentivized to contribute through reward mechanisms.
It helps to create a sustainable funding stream for educational initiatives.
Deployment
In order to deploy the contract, an instance of the contract should be created with a provided ERC20 token address as the staking token. A blockchain testing environment like Remix, Truffle, or Hardhat can be used for deploying the contract.

Conclusion
The Education Staking Pool smart contract is designed to enable users to financially support educational endeavors while earning rewards for their participation. By leveraging blockchain technology, this smart contract ensures transparency and security for all transactions.
