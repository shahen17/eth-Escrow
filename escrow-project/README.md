Solidity Escrow smart contract project with hardhat.

Try running the following to deploy the contract to goerli testnet.
Im using alchemy as json-rpc provider.

```shell
npx hardhat run scripts/deploy.js --network goerli  
```

Functionalites of the escrow-contract
    - When deployed, The constructor take 2 arguments (arbiters address,beneficiarys address) and the msg.sender(depositor) deposits a certain amount for the escrow deal.
    - Only the arbiter can call all functions.
    - Fallback function to recieve extra ether
    - PartialPay option
    - Refund back to depositor option
    - Contract selfDestruct option

Check INTERACT directory to find the ethers.js code to interact with the smart contract after deployment.