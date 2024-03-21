// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console.sol";


import {BaseScript} from "./Base.s.sol";
import {Quoter} from "../contracts/lens/Quoter.sol";

contract DeployQuoterScript is BaseScript {
    function run() public broadcast {
        console.log("Deploying Quoter");
        new Quoter(_poolManagerAddress);
    }
}
