import { ethers } from "ethers";
import { execSync } from "node:child_process";

const ETH_RPC = "http://127.0.0.1:8545";
const IBT_ADDRESS = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

// Sui info (from your publish output)
const SUI_PACKAGE = "0xeb83581ca9af40e276de8ccc3f98adc0a2b9c1a48987489895fa6de77cf13724";
const SUI_TREASURY_CAP = "0xc1680eca3a38c3752d3ff00fe6845a847fe0d498625b1793df6edbadf1cbc933";

// Minimal ABI: only the Deposit event
const ABI = [
  "event Deposit(address indexed from, uint256 amount, string suiAddress)"
];

async function main() {
  const provider = new ethers.JsonRpcProvider(ETH_RPC);
  const contract = new ethers.Contract(IBT_ADDRESS, ABI, provider);

  console.log("Relayer started.");
  console.log("Listening for Ethereum Deposit events on:", IBT_ADDRESS);

  contract.on("Deposit", async (from, amount, suiAddress, event) => {
    try {
      console.log("\n[Deposit detected]");
      console.log("from:", from);
      console.log("amount:", amount.toString());
      console.log("suiAddress:", suiAddress);
      console.log("txHash:", event.log.transactionHash);

      // Mint on Sui via CLI call (simple + reliable for a student project)
      const cmd = `sui client call \
--package ${SUI_PACKAGE} \
--module ibt \
--function mint \
--args ${SUI_TREASURY_CAP} ${suiAddress} ${amount.toString()} \
--gas-budget 5000000`;

      console.log("\nMinting on Sui...");
      const out = execSync(cmd, { stdio: "pipe" }).toString();
      console.log(out);
      console.log("✅ Minted on Sui for", suiAddress);
    } catch (e) {
      console.error("❌ Relayer error:", e.message);
    }
  });
}

main().catch(console.error);
