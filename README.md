# IBT-Centralized-Bridge
Blockchain Technology Final Project- A simple centralized bridge built as a final project for Introduction to Blockchain. The project connects a local Ethereum blockchain and a local Sui network, allowing users to transfer IBT tokens between chains by burning tokens on the source chain and minting them on the destination chain via a relayer.
# IBT – Centralized Bridge 🌉

This project is a **centralized token bridge** built as part of the *Introduction to Blockchain – Final Project*.

The goal was to bridge a custom token (**IBT – Intro Blockchain Token**) between **Ethereum (local Anvil network)** and **Sui (localnet)** using a centralized relayer.

Although the project was quite complex, I’m happy I managed to implement and fully connect all components end-to-end.

---

##  Architecture Overview

- **Ethereum (Anvil)**
  - Solidity smart contract implementing IBT
  - Supports minting, burning, and deposits to the bridge
- **Sui (Localnet)**
  - Move smart contract implementing IBT
  - Token is mintable and burnable only by the deployer
- **Relayer (Node.js)**
  - Listens for Ethereum `Deposit` events
  - Mints IBT on Sui when a deposit is detected
- **Wallets**
  - Ethereum: Anvil accounts (MetaMask-compatible)
  - Sui: Sui CLI wallet

---

##  Project Structure

```text
ibt-bridge

