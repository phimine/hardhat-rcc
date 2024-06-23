// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

error Shipping__IncorrectStatus();

/**
 * @title 将创建的智能合约⽤于跟踪从在线市场购买的商品的状态。
 * 创建该合约时，装运状态设置为 Pending 。
 * 装运商品后，则将装运状态设置为 Shipped 并会发出事件。
 * 交货后，则将商品的装 运状态设置为 Delivered ，并发出另⼀个事件。
 * @author Carl Fu
 * @notice
 */
contract Shipping {
    enum ShippingStatus {
        Pending,
        Shipped,
        Delivered
    }

    event LogNewAlert(string message);

    ShippingStatus private status;

    constructor() {
        status = ShippingStatus.Pending;
    }

    function ship() public {
        if (status != ShippingStatus.Pending) {
            revert Shipping__IncorrectStatus();
        }
        status = ShippingStatus.Shipped;
        emit LogNewAlert("Your package has been shipped");
    }

    function deliver() public {
        if (status != ShippingStatus.Shipped) {
            revert Shipping__IncorrectStatus();
        }
        status = ShippingStatus.Delivered;
        emit LogNewAlert("Your package has arrived");
    }

    function getStatus(
        ShippingStatus _status
    ) internal pure returns (string memory statusString) {
        if (_status == ShippingStatus.Pending) {
            return "Pending";
        } else if (_status == ShippingStatus.Shipped) {
            return "Shipped";
        } else if (_status == ShippingStatus.Delivered) {
            return "Delivered";
        }
    }

    function viewStatus() public view returns (string memory) {
        ShippingStatus _status = status;
        return getStatus(_status);
    }
}
