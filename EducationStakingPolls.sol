// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract EducationStakingPool {
    using SafeMath for uint256;

    IERC20 public stakingToken; // The ERC20 token being staked
    uint256 public rewardRate; // The reward rate (100 for 0.1)
    uint256 public totalStaked; // Total amount of staked tokens

    struct Stake {
        uint256 amount; // Amount of tokens staked
        uint256 rewardDebt; // Reward debt for the staker
        uint256 lastUpdated; // Last time the staker's amount was updated
    }

    mapping(address => Stake) public stakes; // Track each user's stake

    // Events
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event Claimed(address indexed user, uint256 reward);

    constructor(IERC20 _stakingToken) {
        stakingToken = _stakingToken;
        rewardRate = 100; // Represents 0.1 reward rate (10%)
    }

    // Public function to stake tokens
    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0");
        
        // Transfer staking tokens from user to contract
        stakingToken.transferFrom(msg.sender, address(this), amount);

        // Update the user's stake
        Stake storage userStake = stakes[msg.sender];
        userStake.rewardDebt = userStake.rewardDebt.add(userStake.amount.mul(rewardRate).div(1000));
        userStake.amount = userStake.amount.add(amount);
        userStake.lastUpdated = block.timestamp;

        totalStaked = totalStaked.add(amount);

        emit Staked(msg.sender, amount);
    }

    // Public function to withdraw staked tokens
    function withdraw(uint256 amount) external {
        Stake storage userStake = stakes[msg.sender];
        require(userStake.amount >= amount, "Insufficient staked amount");

        // Update the user's reward debt
        userStake.rewardDebt = userStake.rewardDebt.add(userStake.amount.mul(rewardRate).div(1000));
        userStake.amount = userStake.amount.sub(amount);
        
        totalStaked = totalStaked.sub(amount);

        // Transfer tokens back to the user
        stakingToken.transfer(msg.sender, amount);

        emit Withdrawn(msg.sender, amount);
    }

    // Function to claim rewards
    function claimReward() external {
        Stake storage userStake = stakes[msg.sender];

        // Calculate the current reward
        uint256 reward = userStake.amount.mul(rewardRate).div(1000).add(userStake.rewardDebt);
        userStake.rewardDebt = 0; // Reset the reward debt
        
        // Transfer reward to user
        stakingToken.transfer(msg.sender, reward);

        emit Claimed(msg.sender, reward);
    }

    // Function to view user's stake details
    function viewStake(address user) external view returns (uint256 amount, uint256 rewardDebt) {
        Stake storage userStake = stakes[user];
        return (userStake.amount, userStake.rewardDebt);
    }
}
