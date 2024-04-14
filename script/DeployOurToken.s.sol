// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "../lib/forge-std/src/Script.sol";
import {OurToken} from "../src/ourToken.sol";

contract DeployOurToken is Script {
    uint public constant INTIAL_SUPPLY = 100 ether;

    function run() external returns (OurToken) {
        vm.startBroadcast();
        OurToken ourToken = new OurToken(INTIAL_SUPPLY);

        vm.stopBroadcast();
        return ourToken;
    }
}
