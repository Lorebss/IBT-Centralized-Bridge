// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract IBT is ERC20, Ownable {
    event Deposit(address indexed from, uint256 amount, string suiAddress);
    event Withdraw(address indexed to, uint256 amount);

    constructor() ERC20("Intro Blockchain Token", "IBT") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burnFrom(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);
    }

    function depositToBridge(uint256 amount, string calldata suiAddress) external {
        require(balanceOf(msg.sender) >= amount, "Not enough IBT");
        _transfer(msg.sender, address(this), amount);
        emit Deposit(msg.sender, amount, suiAddress);
    }

    function withdrawFromBridge(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit Withdraw(to, amount);
    }
}
