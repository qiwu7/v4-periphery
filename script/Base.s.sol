// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";

string constant TEST_MNEMONIC = "base base base base base base base base base base base base";
uint32 constant TEST_MNEMONIC_INDEX = 0;

/**
 * @title Base Script
 * @dev Boilerplate for running scripts with a broadcaster
 * from either a specific Ethereum address or a mnemonic.
 */
abstract contract BaseScript is Script {
    string internal _mnemonic;
    uint32 internal _mnemonicIndex;

    address internal _broadcaster;

    address internal _poolManagerAddress;

    constructor() {
        _broadcaster = vm.envOr({name: "BROADCASTER", defaultValue: address(0)});
        if (_broadcaster == address(0)) {
            _mnemonic = vm.envOr({name: "MNEMONIC", defaultValue: TEST_MNEMONIC});
            _mnemonicIndex = uint32(vm.envOr({name: "MNEMONIC_INDEX", defaultValue: TEST_MNEMONIC_INDEX}));
            (_broadcaster,) = deriveRememberKey({mnemonic: _mnemonic, index: _mnemonicIndex});
        }

        _poolManagerAddress = vm.envAddress("POOL_MANAGER_ADDRESS");
        require(_poolManagerAddress != address(0), "missing POOL_MANAGER_ADDRESS");
    }

    modifier broadcast() {
        vm.startBroadcast(_broadcaster);
        _;
        vm.stopBroadcast();
    }

    function envAddress(string memory name) internal view returns (address) {
        address addr = vm.envAddress(name);
        require(addr != address(0), string(abi.encodePacked("missing ", name)));
        return addr;
    }

    function envBytes32(string memory name) internal view returns (bytes32) {
        bytes32 data = vm.envBytes32(name);
        require(data != bytes32(0), string(abi.encodePacked("missing ", name)));
        return data;
    }
}