const { expect } = require("chai");
const { ethers } = require("hardhat");

// describe("Token Contract", function() {
//     it("Deployment should assign the total supply of tokens to owner", async function() {
//         const [owner] = await ethers.getSigners();

//         const Token = await ethers.getContractFactory("Token"); // instance of the contract
//         const hardhatToken = await Token.deploy(); // deploy

//         const ownerBalance = await hardhatToken.balanceOf(owner.address); // get balance
//         const totalSupply = await hardhatToken.totalSupply(); // get total supply as BigNumber

//         console.log("Owner address:", owner.address);
//         console.log("Total Supply:", totalSupply.toString());

//         expect(totalSupply).to.equal(ownerBalance);
//     });

//     it("Should transfer tokens between accounts", async function() {
//         const [owner, addr1, addr2] = await ethers.getSigners();

//         const Token = await ethers.getContractFactory("Token"); // instance of the contract
//         const hardhatToken = await Token.deploy(); // deploy

//         // transfer 50t from owner to addr1
//         await hardhatToken.transfer(addr1.address, 50);

//         expect(await hardhatToken.balanceOf(addr1.address)).to.equal(50);

//         // transfer 25t from addr1 to addr2
//         await hardhatToken.connect(addr1).transfer(addr2.address, 25);
//         expect(await hardhatToken.balanceOf(addr1.address)).to.equal(25);
//         expect(await hardhatToken.balanceOf(addr2.address)).to.equal(25);
//     });
// });


describe("Token Contract", function() {

    let Token;
    let hardhatToken;
    let owner;
    let addr1;
    let addr2;
    let addrs;

    beforeEach(async function() { // hook that runs before every it statement
        Token = await ethers.getContractFactory("Token");
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        hardhatToken = await Token.deploy();

    })

    describe("Deployment", function() {
        it("Should set the right owner", async function(){
            expect(await hardhatToken.owner()).to.equal(owner.address)
        })
        it("Should assign total supply to the owner", async function(){
            const ownerBalance = await hardhatToken.balanceOf(owner.address);
            const totalSupply = await hardhatToken.totalSupply(); // get total supply as BigNumber

           expect(totalSupply).to.equal(ownerBalance);
        })
    })

    describe("Transactions", function() {
        it("Should transfer tokens between accounts", async function(){

            await hardhatToken.transfer(addr1.address, 50); // owner to addr1
            const addr1Balance = await hardhatToken.balanceOf(addr1.address);
            expect(addr1Balance).to.equal(50);

            // addr1 to addr2
            await hardhatToken.connect(addr1).transfer(addr2.address, 30);
            expect(await hardhatToken.balanceOf(addr2.address)).to.equal(30);
            expect(await hardhatToken.balanceOf(addr1.address)).to.equal(20);
        })
        
        it("Should fail if sender doesn't have enough tokens", async function(){

            const initialOwnerBalance = await hardhatToken.balanceOf(owner.address);
            await expect(hardhatToken.connect(addr1).transfer(owner.address,100)).to.be.revertedWith("Not enough tokens.");
            expect(await hardhatToken.balanceOf(owner.address)).to.equal(initialOwnerBalance);              
        })

        it("Should update balances after transfers", async function(){

            const initialOwnerBalance = await hardhatToken.balanceOf(owner.address);
            
            await hardhatToken.transfer(addr1.address, 10); // owner to addr1
            await hardhatToken.transfer(addr2.address, 20); // owner to addr2

            const finalOwnerBalance = await hardhatToken.balanceOf(owner.address);
            expect(finalOwnerBalance).to.equal(initialOwnerBalance-30);     

            const addr1Balance = await hardhatToken.balanceOf(addr1.address);
            expect(addr1Balance).to.equal(10);     

            const addr2Balance = await hardhatToken.balanceOf(addr2.address);
            expect(addr2Balance).to.equal(20); 
        })
        
    })


})