const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Hardhat smoke", function () {
  it("compiles and deploys RuleWhitelist", async function () {
    const [admin, listed] = await ethers.getSigners();

    const RuleWhitelist = await ethers.getContractFactory("RuleWhitelist");
    const rule = await RuleWhitelist.deploy(admin.address, ethers.ZeroAddress, true, false);
    await rule.waitForDeployment();

    expect(await rule.listedAddressCount()).to.equal(0n);

    await rule.addAddress(listed.address);
    expect(await rule.isAddressListed(listed.address)).to.equal(true);
  });
});

