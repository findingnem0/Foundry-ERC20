// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract OurToken is ERC20 {
    constructor(uint _intialSupply) ERC20("Nemo", "nem0x001") {
        _mint(msg.sender, _intialSupply);
    }
}
