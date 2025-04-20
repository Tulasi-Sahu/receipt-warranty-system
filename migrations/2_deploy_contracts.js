const ReceiptWarranty = artifacts.require("ReceiptWarranty");

module.exports = function (deployer) {
  deployer.deploy(ReceiptWarranty);
};
