const DevToken = artifacts.require("DevToken");

//Start a test series named DevToken, it will use 10 test accounts
constract("DevToken", async (accounts) => {
  //each it is a new test and we name our first test initial supply
  it("initial Supply", async () => {
    // wait until devtoken is deployed, store the results inside devToken
    // the result is a client to the Smart contract api

    devToken = await DevToken.deployed();

    //call our totalSupply function
    let supply = await devToken.totalSupply();

    // Assert that the supply matches what we set in migration
    assert.equal(supply.toNumber(), 5000000, "Initial supply was not the same as in migration");
  });
});
