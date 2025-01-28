# Enhanced Cross-Chain Oracle Smart Contract

## Overview
This smart contract is a robust **Cross-Chain Oracle System** built on the **Stacks blockchain**, designed to facilitate decentralized, reliable, and verifiable data aggregation and retrieval. It includes features like **oracle registration, reputation management, staking, governance, and rewards distribution**. The contract ensures the integrity of oracle data and provides mechanisms to slash stakes for misbehavior, enhancing trust in the system.

---

## Features

### 1. **Oracle Provider Registration**
Oracle providers can register by staking a minimum amount of STX tokens. Registered providers gain access to submit data and earn rewards.

### 2. **Reputation and Stake Management**
Providers build reputation through successful submissions. Their stake is maintained as collateral to ensure good behavior, which can be slashed for misconduct.

### 3. **Data Storage and Retrieval**
The contract stores data submitted by providers and associates it with metadata, such as timestamps and expiration details, ensuring traceability and transparency.

### 4. **Governance**
The contract enables proposals for network upgrades. Community members can vote on these proposals to guide the contract's future evolution.

### 5. **Rewards Distribution**
A rewards pool accumulates slashed stakes and distributes them to high-reputation providers, incentivizing quality submissions.

### 6. **Accountability Mechanism**
The contract allows the slashing of provider stakes for misbehavior or submission of invalid data.

---

## Contract Components

### 1. **Constants**
- **`CONTRACT-OWNER`**: Owner of the contract with elevated permissions.
- **Error Codes**: Defined for specific scenarios:
  - `ERR-UNAUTHORIZED`
  - `ERR-INVALID-DATA`
  - `ERR-INSUFFICIENT-FUNDS`
  - `ERR-PROVIDER-ALREADY-EXISTS`
  - `ERR-DATA-EXPIRATION`

---

### 2. **Data Storage**

#### **Oracle Providers (`oracle-providers`)**
A mapping to track registered oracle providers:
- **`reputation`**: Provider's reputation score.
- **`stake`**: Amount staked by the provider.
- **`is-active`**: Whether the provider is active.
- **`total-submissions`**: Total number of data submissions.
- **`successful-submissions`**: Count of valid submissions.

#### **Oracle Data (`oracle-data`)**
Stores submitted oracle data with metadata:
- **`value`**: Submitted data.
- **`provider`**: Address of the submitting provider.
- **`timestamp`**: Time of submission.
- **`expiration`**: Data expiration time.

#### **Network Proposals (`network-proposals`)**
Tracks proposals for network upgrades:
- **`proposal-type`**: Type of proposal (e.g., upgrade parameter).
- **`proposed-value`**: Proposed value for the upgrade.
- **`total-votes`**: Number of votes cast.
- **`votes-for`**: Votes in favor.
- **`votes-against`**: Votes against.
- **`status`**: Whether the proposal is approved.

#### **Rewards Pool (`rewards-pool`)**
Holds slashed funds for distribution to providers as rewards.

---

### 3. **Public Functions**

#### **Oracle Registration**
- **`register-provider (initial-stake uint)`**
  - Registers a new provider by staking a minimum of `1000 STX`.
  - Verifies that the provider is not already registered.

#### **Stake for Reputation**
- **`stake-for-reputation (amount uint)`**
  - Allows a provider to stake additional STX to boost their reputation.

#### **Retrieve Data**
- **`get-data (data-key string-ascii 50)`**
  - Retrieves oracle data for a given key.

#### **Propose Network Upgrades**
- **`create-proposal (proposal-type string-ascii 50, proposed-value uint)`**
  - Allows the contract owner to create proposals for network changes.

#### **Increment and Set Block Height**
- **`increment-block-height`**: Simulates block height progression.
- **`set-block-height (new-height uint)`**: Manually sets the block height for testing.

#### **Claim Rewards**
- **`claim-rewards`**
  - Distributes rewards from the pool to high-reputation providers.

#### **Slash Provider Stake**
- **`slash-provider-stake (provider principal, slash-amount uint)`**
  - Reduces a provider's stake and halves their reputation for misconduct.

---

### 4. **Read-Only Functions**

- **`get-data (data-key string-ascii 50)`**: Retrieves data stored in the contract.
- **`get-block-height`**: Returns the current block height.

---

## Key Functionalities

### Oracle Lifecycle
1. **Registration**: Providers register by staking STX and gain the ability to submit data.
2. **Data Submission**: Providers submit data with metadata, including timestamps.
3. **Reputation Building**: Providers earn reputation for successful submissions.
4. **Staking for Reputation**: Providers can increase reputation by staking more STX.

### Governance
- Proposals for network upgrades are submitted by the contract owner.
- Community members vote on proposals, deciding their implementation.

### Rewards Distribution
- Slashed stakes are added to the rewards pool.
- High-reputation providers can claim rewards from the pool.

### Misconduct Handling
- Misbehavior results in stake slashing and reduced reputation, protecting the network.

---

## Security Considerations

1. **Access Control**: 
   - Only the `CONTRACT-OWNER` can slash stakes and create proposals.
2. **Reputation Incentives**: 
   - Providers with high reputation have more to lose, discouraging misconduct.
3. **Stake Requirements**:
   - Providers must maintain a minimum stake to remain active.

---

## Testing and Deployment

1. **Initialization**:
   - Deploy the contract on the Stacks testnet.
   - Initialize the block height using `set-block-height`.

2. **Testing**:
   - Test provider registration, data submission, and reputation adjustments.
   - Simulate governance proposals and voting.
   - Verify reward claims and slashing functionality.

3. **Deployment**:
   - Deploy on the Stacks mainnet after thorough testing.

---

### You are also free to contribute

## Usage in the Stacks Ecosystem
This contract integrates seamlessly into the Stacks ecosystem by leveraging the following:
- **Stacks Tokens (STX)**: Used for staking and rewards.
- **Clarity Smart Contract Language**: Ensures deterministic execution and security.
- **Decentralized Governance**: Empowers the community to guide the network's development.

This system is ideal for applications requiring cross-chain data verification, such as **DeFi protocols, NFT marketplaces, and supply chain tracking systems**.