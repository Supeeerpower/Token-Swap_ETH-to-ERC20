//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

interface IPool {
  struct PoolModel {
    uint256 hardCap; // how much project wants to raise
    uint256 softCap; // how much of the raise will be accepted as successful IDO
    uint256 startDateTime;
    uint256 endDateTime;
    PoolStatus status; //: by default “Upcoming”,
  }

  struct IDOInfo {
    address walletAddress; // address where Ether is sent
    address projectTokenAddress; //the address of the token that project is offering in return
    uint16 minAllocationPerUser;
    uint256 maxAllocationPerUser;
    uint256 totalTokenProvided;
    uint256 exchangeRate;
    uint256 tokenPrice;
    uint256 totalTokenSold;
  }

  // Pool data that needs to be retrieved:
  struct CompletePoolDetails {
    Participations participationDetails;
    PoolModel pool;
    IDOInfo poolDetails;
    uint256 totalRaised;
  }

  struct Participations {
    ParticipantDetails[] investorsDetails;
    uint256 count;
  }

  struct ParticipantDetails {
    address addressOfParticipant;
    uint256 totalRaisedInWei;
  }

  enum PoolStatus {
    Upcoming,
    Ongoing,
    Finished,
    Paused,
    Cancelled
  }

  function addIDOInfo(IDOInfo memory _detailedPoolInfo) external;

  function getCompletePoolDetails()
    external
    view
    returns (CompletePoolDetails memory poolDetails);

  function updatePoolStatus(uint256 _newStatus) external;

  function deposit(address _sender) external payable;

  function unclaimedTokens(address _participant)
    external
    view
    returns (uint256 _tokensAmount);
}
