// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9; 
// Définition du contrat de vote
contract Vote {
    
    string[] public options;
    
    mapping (string => uint256) public votes;
    
    // L'événement qui est déclenché lorsqu'un vote est enregistré
    event NewVote(string option, uint256 voteCount);
    
    // La fonction pour ajouter des options de vote
    function addOption(string memory option) public {
        options.push(option);
    }
    
    // La fonction pour voter
    function vote(string memory option) public {
        require(isValidOption(option), "Option de vote invalide.");
        votes[option] += 1;
        emit NewVote(option, votes[option]);
    }
    
    // La fonction pour vérifier si une option de vote est valide
    function isValidOption(string memory option) public view returns (bool) {
        for (uint i = 0; i < options.length; i++) {
            if (keccak256(bytes(options[i])) == keccak256(bytes(option))) {
                return true;
            }
        }
        return false;
    }
}




