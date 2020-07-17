// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

contract Election {
    // Candidate Model
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }
    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Canditate
    mapping(uint256 => Candidate) public candidates;

    // Store Candidates Count
    uint256 public candidatesCount;

    // Voted Event
    event votedEvent(uint256 indexed _candidateId);

    // Constructor
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    // Add Candidate Function
    function addCandidate(string memory _name) private {
        candidatesCount++;
        /*
         ** Adding candidate follwing struct model Candidate(uid=>candidatesCount, name=> _name, voteCount=>0)
         */
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint256 _candidateId) public {
        // Check address has voted only once
        require(!voters[msg.sender], "You cannot vote twice.");
        // Check for valid candidate
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid candidate Id."
        );
        // Store Voter Has Voted
        voters[msg.sender] = true;
        // Update Candidate Vote Count
        candidates[_candidateId].voteCount++;

        // Trigger Voted Event Function
        emit votedEvent(_candidateId);
    }
}
