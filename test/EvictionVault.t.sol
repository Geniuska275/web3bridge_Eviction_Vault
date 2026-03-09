// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/EvictionVault.sol";

contract EvictionVaultTest is Test {

    EvictionVault vault;

    address owner;
    address user;

    function setUp() public {

        owner = address(this);
        user = address(1);

        vault = new EvictionVault();

        vm.deal(user, 10 ether);
    }

    /* ---------------------------------------------------------- */
    /*                       DEPOSIT TEST                         */
    /* ---------------------------------------------------------- */

    function testDepositETH() public {

        vm.prank(user);

        (bool success,) = address(vault).call{value: 1 ether}("");
        require(success);

        uint256 balance = vault.balances(user);

        assertEq(balance, 1 ether);
    }

    /* ---------------------------------------------------------- */
    /*                       WITHDRAW TEST                        */
    /* ---------------------------------------------------------- */

    function testWithdrawETH() public {

        vm.startPrank(user);

        (bool success,) = address(vault).call{value: 1 ether}("");
        require(success);

        vault.withdraw(1 ether);

        vm.stopPrank();

        assertEq(user.balance, 10 ether);
        assertEq(vault.balances(user), 0);
    }

    /* ---------------------------------------------------------- */
    /*                        PAUSE TEST                          */
    /* ---------------------------------------------------------- */

    function testPauseSystem() public {

        vault.pause();

        bool paused = vault.paused();

        assertTrue(paused);
    }

    /* ---------------------------------------------------------- */
    /*                  EMERGENCY WITHDRAW TEST                   */
    /* ---------------------------------------------------------- */

    function testEmergencyWithdraw() public {

        vm.deal(address(vault), 2 ether);

        vault.pause();

        uint256 ownerBalanceBefore = address(this).balance;

        vault.emergencyWithdrawAll(payable(address(this)));

        uint256 ownerBalanceAfter = address(this).balance;

        assertEq(ownerBalanceAfter, ownerBalanceBefore + 2 ether);
    }
}