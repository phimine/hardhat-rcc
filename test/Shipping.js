const { expect } = require("chai")
const hre = require("hardhat")

describe("Shipping", () => {
    let shippingContract

    beforeEach(async () => {
        shippingContract = await hre.ethers.deployContract("Shipping", [])
    })

    // "should return the status Pending"
    it("should return the status Pending", async () => {
        expect(await shippingContract.viewStatus()).to.equal("Pending")
    })

    //should return the status Shipped
    it("should return the status Shipped", async () => {
        await shippingContract.ship()
        expect(await shippingContract.viewStatus()).to.equal("Shipped")
    })

    it("should return correct event description - Shipped", async () => {
        expect(shippingContract.ship())
            .to.emit(shippingContract, "LogNewAlert")
            .withArgs("Your package has been shipped")
    })

    //should return the status Shipped
    it("should revert with customer error -- Shipped", async () => {
        await shippingContract.ship()
        expect(await shippingContract.viewStatus()).to.equal("Shipped")
        expect(shippingContract.ship()).to.revertedWithCustomError(
            shippingContract,
            "Shipping__IncorrectStatus",
        )
    })

    it("should return the status Delivered", async () => {
        await shippingContract.ship()
        expect(await shippingContract.viewStatus()).to.equal("Shipped")
        await shippingContract.deliver()
        expect(await shippingContract.viewStatus()).to.equal("Delivered")
    })

    it("should revert with customer error", async () => {
        await expect(shippingContract.deliver()).to.revertedWithCustomError(
            shippingContract,
            "Shipping__IncorrectStatus",
        )
    })

    it("should return correct event description", async () => {
        await shippingContract.ship()
        expect(await shippingContract.viewStatus()).to.equal("Shipped")
        await expect(shippingContract.deliver())
            .to.emit(shippingContract, "LogNewAlert")
            .withArgs("Your package has arrived")
    })
})
