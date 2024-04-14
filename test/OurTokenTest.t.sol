// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "../lib/forge-std/src/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/ourToken.sol";

contract OurTokenTest is Test {
    DeployOurToken public deployer;
    OurToken public ourToken;
    uint public constant STARTING_BALANCE = 100 ether;
    uint public transferAmount = 500;
    address bob = makeAddr("bob");
    address alice = makeAddr("Alice");

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();
        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testTotalSupply() public {
        assertEq(ourToken.totalSupply(), STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowances() public {
        uint intitalAllowance = 1000;
        vm.prank(bob);
        ourToken.approve(alice, intitalAllowance);
        vm.prank(alice);
        uint transferAmount = 500;
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransferFromWithoutApproval() public {
        uint startingBalance = ourToken.balanceOf(bob);
        uint transferAmount = 50;
        vm.expectRevert();
        ourToken.transferFrom(bob, alice, transferAmount);
        // Ensure that the transferFrom failed due to lack of approval
        assertEq(ourToken.balanceOf(alice), 0);
        assertEq(ourToken.balanceOf(bob), startingBalance);
    }
}
