// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import './HostalAgentService.sol';

contract Hostal {

  //The data structure of a hostel
  struct Hostel {
    address payable owner;
    string name;
    string image;
    string description;
    string location;
    uint serviceFee;
    uint price;
    uint sold;
    uint numOfRooms;
  }

  //Stores the total number of hostels posted
  uint internal hostelsLength = 0;
  address payable internal ownerAddress;
  address payable internal serviceAddress;

  //Creating an instance of the interface
  ServiceInterface internal ServiceContract;

  //Mapping used to store all the hostels
  mapping (uint => Hostel) internal hostels;

  //Address of the ERC-20 token
  address internal cUsdTokenAddress = 0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

  //Event that will emit when a new hostal is listesd o
  event newHostal(address indexed owner, uint price);

  //Event that will emit if a hostal is bought
  event hostalBought(address indexed owner, uint price, address indexed buyer);

  /*In the constructor, we initialize the address of the service contract, 
  address of the owner and the instance of the interface by the address of the actual contract */

  constructor(address serviceContractAddress) {
    ownerAddress = payable(msg.sender);
    serviceAddress = payable(serviceContractAddress);
    ServiceContract = ServiceInterface(address(serviceContractAddress));
  }

  //Function to add hostels
  function writeHostels(
    string memory _name,
    string memory _image,
    string memory _description, 
    string memory _location,
    uint _serviceFee,
    uint _price,
    uint _numOfRooms
  ) public {
    uint _sold = 0;
    hostels[hostelsLength] = Hostel(
      payable(msg.sender),
      _name,
      _image,
      _description,
      _location,
      _serviceFee,
      _price,
      _sold, 
      _numOfRooms
    );
    hostelsLength++;
  }

  //Function to add yourself as an agent by calling the function in the service contract
  function addService(
    string memory _name,
    string memory _image,
    string memory _description, 
    string memory _location,
    string memory _contact,
    uint _rate
  ) public {
    ServiceContract.writeService(_name, _image, _description, _location, _contact, _rate);
  }

  //Function that is used to get the hostels listed
  function readHostel(uint _index) public view returns (
    address payable owner,
    string memory name, 
    string memory image, 
    string memory description, 
    string memory location, 
    uint serviceFee,
    uint price, 
    uint sold,
    uint numOfRooms
  ) {
    Hostel storage hostel = hostels[_index];
    return(
      hostel.owner,
      hostel.name,
      hostel.image,
      hostel.description,
      hostel.location,
      hostel.serviceFee,
      hostel.price,
      hostel.sold,
      hostel.numOfRooms
    );
  }

  //Function used to view the services that are listed
  function getService(uint _index) public view returns(
    address user,
    string memory name, 
    string memory image, 
    string memory description, 
    string memory location, 
    string memory contact,
    uint rate,
    uint hiresLength
  ) {
    return ServiceContract.readService(_index);
  }

  function getServiceHire(uint _serviceIndex, uint _hireIndex) public view returns(
    address hirer,
    uint timestamp
  ) {
    return ServiceContract.readServiceHire(_serviceIndex, _hireIndex);
  }
    
  // hire a service
  function hireService(
   uint _index,
   uint _price
  ) public payable {
    require(
      IERC20Token(cUsdTokenAddress).transferFrom(
        msg.sender,
       serviceAddress,
        _price
      ),
      "Failed to hire this service."
    );

    ServiceContract.hireService(_index);
  }
  
  //Function to book a hostel
  function buyHostel(uint _index) public payable  {
    require(hostels[_index].numOfRooms > 0, "There are no rooms free at the moment");

    require(
      IERC20Token(cUsdTokenAddress).transferFrom(
        msg.sender,
        ownerAddress,
        hostels[_index].serviceFee
      ),
      "hostels fee transfer failed."
    );

    require(
      IERC20Token(cUsdTokenAddress).transferFrom(
        msg.sender,
        hostels[_index].owner,
        hostels[_index].price
      ),
      "hostels price transfer failed."
    );

    hostels[_index].numOfRooms--;
    hostels[_index].sold++;
  }

  //Function through which only the owner can change the number of hostels available
  function editNumOfRoomsAvailable(uint _index, uint _numOfRooms) public{
    require(msg.sender == hostels[_index].owner);
    hostels[_index].numOfRooms = _numOfRooms;
  }
  
  function getHostelsLength() public view returns (uint) {
    return (hostelsLength);
  }

  function getServicesLength() public view returns (uint) {
    return ServiceContract.readServicesLength();
  }
}

/*
  1)Added 2 require statements that prevents users from hiring themselves and ensure
    that one can hire one agent only once
      1.1)Added a mapping in the service struct that stored the addresses that has 
          bought the service
  2)Refactored the events in the HostalAgentService contract to only have arguments 
    that are vital
  3)Added a functionality where the user can add the number of rooms available for the
    particular hostal and can also edit the number of rooms set for booking
  4)Added useful events in the hostal contract
  5)Added comments to improve documentation
*/