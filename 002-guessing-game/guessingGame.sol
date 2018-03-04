pragma solidity ^0.4.17;

contract GuessingGame {
    
    uint nonce = 0;
    
    // Creation of 2 events, when to user lost/won.
    event userWon(address user, uint numberGenerated);
    event userLost(address user, uint numberGenerated);
    
    /**
     * - function (): Default/fallback function. For transactions that are being 
     * sent to an address without transaction data or invalid data.
     * - payable: as the contract is to accept transactions (he amount of gas sent 
     * with a trivial send is not enough to change a state variable but is enough 
     * to log an event).
     */
    function() public payable { }
    
    /**
     * - view: This is generally the replacement for constant. It indicates that
     * the function will not alter the storage state in any way.
     * - pure: This is even more restrictive, indicating that it won't even read
     * the storage state mostly determined by it's parameters(input values).
     */
    function getBalance() public view returns(uint) {
        return this.balance;
    }
    
    /**
     * Double your ether by playing odd or even with 0.01 ether.
     */
    function play() public payable {
        // Only allow plays with 0.01 ether.
        if (msg.value != 0.01 ether) {
            // Prevent overflow.
            assert(msg.value == 0.01 ether);
            // Only owner can send ether.
            //require(msg.sender == owner);
            // Prevent overflow.
            //assert(balance[owner] + msg.value >= balance[owner]);
            // Accept only upto an amount.
            //if(balance[owner] + msg.value > maximum) revert();
            // Log the deposit.
            //Deposit(msg.sender, msg.value);
            // Careful, no guarantee there will be enough gas for this.
            //balance[owner] += msg.value;
        }
        // Generate a random number.
        uint randomNumber = uint(keccak256(block.blockhash(block.number), nonce)) % 100;
        nonce++;
        // Check if the user lost or won.
        if (randomNumber%2 == 0) {
            msg.sender.transfer(msg.value * 2);
            userWon(msg.sender, randomNumber);
        } else {
            userLost(msg.sender, randomNumber);
        }
    }
}
