// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReceiptWarranty {
    struct Certificate {
        address customer;
        string name;
        uint256 validTill;
    }

    mapping(address => mapping(string => Certificate)) public certificates;

    event CertificateIssued(address indexed retailer, string productId, address customer);

    function issueCertificate(
        string memory _productId,
        address _customer,
        string memory _productName,
        uint256 _warrantyMonths
    ) public {
        require(_customer != address(0), "Invalid customer address");
        require(bytes(_productId).length > 0, "Invalid product ID");

        uint256 validTill = block.timestamp + (_warrantyMonths * 30 days);

        certificates[msg.sender][_productId] = Certificate(
            _customer,
            _productName,
            validTill
        );

        emit CertificateIssued(msg.sender, _productId, _customer);
    }

    function getCertificate(address _retailer, string memory _productId)
        public
        view
        returns (Certificate memory)
    {
        return certificates[_retailer][_productId];
    }

    function isWarrantyValid(address _retailer, string memory _productId)
        public
        view
        returns (bool)
    {
        Certificate memory cert = certificates[_retailer][_productId];
        return (block.timestamp <= cert.validTill);
    }
}
