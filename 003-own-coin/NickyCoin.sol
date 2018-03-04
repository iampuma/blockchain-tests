pragma solidity ^0.4.20;

contract NickyCoin {
    // public will make the variables accessible outside the contract as done
    // by the compiler automatically. E.g. how this actually would represent:
    // function minter() returns (address) { return minter; }
    address public minter;
    // Mapping of address to uint. No lookup is possible of keys/values.
    // Mappings can be seen as hash tables which are virtually initialized such 
    // that every possible key exists and is mapped to a value whose 
    // byte-representation is all zeros. E.g. public keyword would represent:
    // function balances(address _account) public view returns(uint) {
    //    return balances[_account];
    // }
    mapping (address => uint) public balances;

    // Events allow light clients to react on changes efficiently.
    // Listing would be something like the following:
    // NickyCoin.Sent().watch({}, '', function(error, result) {
    //   if (!error) {
    //     console.log("Coin transfer: " + result.args.amount + " coins were 
    //         sent from " + result.args.from +  " to " + result.args.to + ".");
    //     console.log("Balances now:\n" +  "Sender: " + 
    //                 Coin.balances.call(result.args.from) + "Receiver: " + 
    //                 Coin.balances.call(result.args.to));
    //   }
    //})
    event Sent(address from, address to, uint amount);

    // Constructor whose code is run only upon contract creation.
    function NickyCoin() public {
        // Set the minter address to the owner of the contract.
        minter = msg.sender;
    }

    // Only allow minting for the owner of the contract.
    function mint(address receiver, uint amount) public {
        if (msg.sender != minter) return;
        balances[receiver] += amount;
    }

    // Send some NickyCoins to some address.
    function send(address receiver, uint amount) public {
        // Do not allow sending of coins the sender does not have.
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Sent(msg.sender, receiver, amount);
    }
}
