const { ethers } = require("ethers");
const hre = require("hardhat");

async function main() {
  // Get the contract factory
  const AirdropToken = await hre.ethers.getContractFactory("AirdropToken");

  // Deploy the contract
  const airdropToken = await AirdropToken.deploy(
    "0xeb68e5fbe0fa33419f8ec88f425ad2a50a59fa12",
    1000
  ); // Replace "TOKEN_ADDRESS" with the actual token address

  // Wait for the deployment to be confirmed
  await airdropToken.deployed();

  // Log the address of the deployed contract
  console.log("AirdropToken deployed to:", airdropToken.address);
}

// Execute the main function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
