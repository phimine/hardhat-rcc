// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20MinerReward is ERC20 {
    event LogNewAlert(string message, address indexed _to, uint256 _num);

    constructor() ERC20("MinerReward", "MRW") {}

    function reward() public {
        _mint(block.coinbase, 20);
        emit LogNewAlert("REWARDED", block.coinbase, block.number);
    }
}
