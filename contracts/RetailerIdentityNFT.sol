// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RetailerIdentityNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;

    struct Retailer {
        uint256 retailerID;
        address retailerAddress;
        string businessName;
        bool isVerified;
    }

    mapping(uint256 => Retailer) public retailers;
    mapping(address => bool) public isRetailer;

    constructor() ERC721("RetailerIdentityNFT", "RINFT") Ownable(msg.sender){}

    function mintRetailerNFT(address retailer, string memory businessName, bool verificationStatus, string memory metadataURI) public onlyOwner {
        _tokenIds++;
        uint256 newTokenId = _tokenIds;
        _mint(retailer, newTokenId);
        _setTokenURI(newTokenId, metadataURI);

        retailers[newTokenId] = Retailer(newTokenId, retailer, businessName, verificationStatus);
        isRetailer[retailer] = true;
    }

    function verifyRetailer(uint256 retailerID, bool status) public onlyOwner {
        retailers[retailerID].isVerified = status;
    }

    function getRetailerDetails(uint256 retailerID) public view returns (Retailer memory) {
        return retailers[retailerID];
    }
}


//deployed to:  0x1275dF8341812cE1Fd74e6564141DCC3e2BAc848