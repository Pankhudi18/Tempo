import { ethers } from "hardhat";

async function main() {

  //Farmer Identity
  // const FarmerIdentityNFT = await ethers.getContractFactory("FarmerIdentityNFT");
  // const farmerIdentityNFT = await FarmerIdentityNFT.deploy();

  // console.log(`FarmerIdentityNFT deployed to: ${await farmerIdentityNFT.getAddress()}`);

  //Retailer Identity
  const RetailerIdentityNFT = await ethers.getContractFactory("RetailerIdentityNFT");
  const retailerIdentityNFT = await RetailerIdentityNFT.deploy();
  await retailerIdentityNFT.waitForDeployment();
  console.log(`RetailerIdentityNFT deployed to: ${await retailerIdentityNFT.getAddress()}`);

  //Deploy Traceable Product NFT
  const TraceableProductNFT = await ethers.getContractFactory("TraceableProductNFT");
  const traceableProductNFT = await TraceableProductNFT.deploy();
  await traceableProductNFT.waitForDeployment();
  console.log(`TraceableProductNFT deployed to: ${await traceableProductNFT.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

