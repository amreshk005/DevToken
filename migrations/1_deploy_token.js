// Make sure the DevToken is included by requering it.
const DevToken = artifacts.require("DevToken");

// This is an async function, it will accept the Deployer account, the network, and eventtual accounts.
module.exports = async function (deployer, network, accounts) {
  // await while we deploy the DevToken
  await deployer.deploy(DevToken, "DevToken", "DVTK", 18, 1000);
  const devToken = await DevToken.deployed();
  let totalSupply = await devToken.totalSupply();
  console.log(totalSupply.toNumber());
};
