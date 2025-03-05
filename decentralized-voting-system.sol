// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint public candidatesCount;
    string public electionName;
    address public electionOwner;

    event CandidateAdded(uint id, string name);
    event Voted(uint candidateId);

    constructor(string memory _electionName) {
        electionName = _electionName;
        electionOwner = msg.sender;
    }

    function addCandidate(string memory _name) public {
        require(msg.sender == electionOwner, "Only the owner can add candidates");
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        emit Voted(_candidateId);
    }

    function getCandidate(uint _candidateId) public view returns (Candidate memory) {
        return candidates[_candidateId];
    }
}