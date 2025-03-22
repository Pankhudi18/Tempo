// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TraceableProductNFT is ERC1155, Ownable {
    constructor() ERC1155("ipfs://QmXYZ/{id}.json") Ownable(msg.sender) {}
    
    uint256 private _tokenIds;
    
    struct ProductTrace {
        uint256 productId;
        address farmer;
        string productDetailsHash; // IPFS Hash of product details
        address[] supplyChain;
        uint256[] timestamps;
    }
    
    mapping(uint256 => ProductTrace) public products;
    
    event ProductMinted(uint256 indexed productId, address indexed farmer, string productDetailsHash);
    event ProductTransferred(uint256 indexed productId, address indexed from, address indexed to, uint256 timestamp);
    
    // ✅ Mint a new product NFT
    function mintProduct(string memory productDetailsHash) public returns (uint256) {
        _tokenIds++;
        uint256 newTokenId = _tokenIds;
        _mint(msg.sender, newTokenId, 1, ""); // Mint NFT to farmer
        products[newTokenId] = ProductTrace({
            productId: newTokenId,
            farmer: msg.sender,
            productDetailsHash: productDetailsHash,
            supplyChain: new address[](0),
            timestamps: new uint256[](0)
        });
        products[newTokenId].supplyChain.push(msg.sender);
        products[newTokenId].timestamps.push(block.timestamp);
        emit ProductMinted(newTokenId, msg.sender, productDetailsHash);
        return newTokenId;
    }
    
    // ✅ Transfer Product NFT
    function transferProduct(address to, uint256 productId) public {
        require(balanceOf(msg.sender, productId) > 0, "You do not own this product");
        require(products[productId].productId != 0, "Product does not exist"); // ✅ Check product existence
        _safeTransferFrom(msg.sender, to, productId, 1, "");
        products[productId].supplyChain.push(to);
        products[productId].timestamps.push(block.timestamp);
        emit ProductTransferred(productId, msg.sender, to, block.timestamp);
    }
    
    // ✅ Get product history
    function getProductHistory(uint256 productId) public view returns (address[] memory, uint256[] memory) {
        require(products[productId].productId != 0, "Product does not exist");
        return (products[productId].supplyChain, products[productId].timestamps);
    }
    
    // ✅ Get product details
    function getProductDetails(uint256 productId) public view returns (ProductTrace memory) {
        require(products[productId].productId != 0, "Product does not exist");
        return products[productId];
    }
}

//TraceableProductNFT deployed to: 0xAB6e26894531D1EC96292b3EE222f8b1Bf9E2439