// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReceiptWarranty {
    struct Product {
        string productId;
        string description;
        address customer;
        uint256 issueDate;
        uint256 warrantyPeriod;
    }

    mapping(string => Product) public receipts;

    function issueReceipt(
        string memory _productId,
        string memory _description,
        address _customer,
        uint256 _warrantyPeriod
    ) public {
        require(receipts[_productId].customer == address(0), "Already issued");
        receipts[_productId] = Product(_productId, _description, _customer, block.timestamp, _warrantyPeriod);
    }

    function getReceipt(string memory _productId)
        public
        view
        returns (
            string memory,
            string memory,
            address,
            uint256,
            uint256
        )
    {
        Product memory p = receipts[_productId];
        return (p.productId, p.description, p.customer, p.issueDate, p.warrantyPeriod);
    }

    function isWarrantyValid(string memory _productId) public view returns (bool) {
        Product memory p = receipts[_productId];
        return (block.timestamp <= p.issueDate + p.warrantyPeriod);
    }
}
