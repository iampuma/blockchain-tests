// Source is written in 0.4 solidity. So only use version compatible compilers.
pragma solidity ^0.4.0;

// Contract is a collection of code and data, that has an address on the Ethereum blockchain.
contract SimpleStorage {
    // Declares a unit type variable (unsigned integer of 256 bits)
    // Think of it as something that represents a single slot in the database.
    uint storedData;

    // Functions can be create to query and alter data.
    function set(uint x) {
        storedData = x;
    }

    // Functions can be create to query and alter data.
    function get() constant returns (uint) {
        return storedData;
    }
    
    // Currently no restrictions are set to the data of this contract,
    // anyone who wants would be allowed to change the data value.
    // Any change of the value will be stored on the blockchain.
}
