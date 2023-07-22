
async function main() {
  const payableAmount = ethers.parseEther("0.001");
  const escrow = await hre.ethers.deployContract("Escrow", ["",""], {
    value: payableAmount,
  });

  await escrow.waitForDeployment();

  console.log(`deployed to ${escrow.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
