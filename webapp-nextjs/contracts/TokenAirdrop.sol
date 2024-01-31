pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenAirdrop is Ownable {
    IERC20 public token;

    event Airdrop(address indexed to, uint256 amount);

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function setToken(address _tokenAddress) external onlyOwner {
        token = IERC20(_tokenAddress);
    }

    function executeAirdrop(address[] calldata recipients, uint256[] calldata amounts) external onlyOwner {
        require(recipients.length == amounts.length, "Arrays length mismatch");

        for (uint256 i = 0; i < recipients.length; i++) {
            require(recipients[i] != address(0), "Invalid recipient address");
            require(amounts[i] > 0, "Invalid amount");

            bool success = token.transfer(recipients[i], amounts[i]);
            require(success, "Token transfer failed");

            emit Airdrop(recipients[i], amounts[i]);
        }
    }

    function modifyAirdropQuantity(address recipient, uint256 newAmount) external onlyOwner {
        require(recipient != address(0), "Invalid recipient address");
        require(newAmount > 0, "Invalid amount");

        bool success = token.transfer(recipient, newAmount);
        require(success, "Token transfer failed");

        emit Airdrop(recipient, newAmount);
    }
}
