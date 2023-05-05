// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9; 
// Définition du contrat de vote
    contract Vote {
// Les options de vote possibles
    string[] public options;

// Les votes enregistrés
    mapping (string => uint256) public votes;

// L'événement qui est déclenché lorsqu'un vote est enregistré
    event NewVote(string option, uint256 voteCount);

// L'événement qui est déclenché lorsqu'on obtient le gagnant
    event GetWinner(string winner, uint256 voteCount);

// Adresse du propriétaire du contrat
    address public owner;

// Vérification que l'appelant est le propriétaire du contrat
    modifier onlyOwner(){
        require(msg.sender == owner, "Seul le proprietaire peut effectuer cette action.");
    _;
    }

// Constructeur du contrat Vote
    constructor () {
        owner = msg.sender;
    }

// Fonction pour changer le propriétaire du contrat
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

// Fonction pour ajouter des options de vote
    function addOption(string memory option) public {
        options.push(option);
    }

// Fonction pour voter
    function vote(string memory option) public {
        require(isValidOption(option), "Option de vote invalide.");
        votes[option] += 1;
        emit NewVote(option, votes[option]);
    }

// Fonction pour vérifier si une option de vote est valide
    function isValidOption(string memory option) public view returns (bool) {
    for (uint i = 0; i < options.length; i++) {
        if (keccak256(bytes(options[i])) == keccak256(bytes(option))) {
            return true;
        }
    }
    return false;
    }

// Fonction pour obtenir le nombre total de votes enregistrés
    function getTotalVotes() public view returns (uint256) {
        uint256 total = 0;
        for (uint i = 0; i < options.length; i++) {
        total += votes[options[i]];
    }
    return total;
    }

// Fonction pour obtenir l'option gagnante
    function getWinner() public  returns (string memory winner) {
        uint256 highestVoteCount = 0;
        for (uint i = 0; i < options.length; i++) {
         if (votes[options[i]] > highestVoteCount) {
            highestVoteCount = votes[options[i]];
            winner = options[i];
        }
    }
    emit GetWinner(winner, highestVoteCount);
    return winner;
    }
}