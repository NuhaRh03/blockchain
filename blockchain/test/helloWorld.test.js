const HelloWorld = artifacts.require("HelloWorld");

contract("HelloWorld", (accounts) => {
  it("should set and get the name", async () => {
    const instance = await HelloWorld.deployed();
    await instance.setName("Imane");
    const name = await instance.yourName();
    assert.equal(name, "Imane", "The name was not set correctly");
  });
});
