// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FarmerIdentityNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;

    struct Farmer {
        uint256 farmerID;
        address farmerAddress;
        string location;
        string certificateHash; // Hash of certification (IPFS)
    }

    mapping(uint256 => Farmer) public farmers;
    mapping(address => bool) public isFarmer;

    constructor() ERC721("FarmerIdentityNFT", "FINFT")Ownable(msg.sender) {}

    function mintFarmerNFT(address farmer, string memory location, string memory certificateHash, string memory metadataURI) public onlyOwner {
        _tokenIds++;
        uint256 newTokenId = _tokenIds;
        _mint(farmer, newTokenId);
        _setTokenURI(newTokenId, metadataURI);

        farmers[newTokenId] = Farmer(newTokenId, farmer, location, certificateHash);
        isFarmer[farmer] = true;
    }

    function getFarmerDetails(uint256 farmerID) public view returns (Farmer memory) {
        return farmers[farmerID];
    }
}


//deployed to the address: 0x985DD022457615Efa91810C34FA4bBe41f01436F
