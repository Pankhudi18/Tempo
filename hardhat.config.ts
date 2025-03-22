import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      { version: "0.8.20" },
      { version: "0.8.28" }
    ]
  },
  networks: {
    sepolia: {
      url: process.env.ALCHEMY_MUMBAI_RPC || process.env.INFURA_API_URL,
      accounts: [process.env.PRIVATE_KEY as string],
    },
  },
};

export default config;
