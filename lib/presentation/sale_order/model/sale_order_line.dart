import 'package:flutter/material.dart';
import 'package:hello/presentation/sale_order/model/so_product_line.dart';

/*

id
order_id
product_id
product_name
description
sale_type
balance_quantity_in_stock
order_quantity
quantity_to_deliver
quantity_to_invoice 
product_uom
product_unit_price
taxes
discount
subtotal


*/

class SaleOrderLine {
  SaleOrderLine(
      {this.id,
      this.orderId,
      this.productId,
      this.productName,
      this.description,
      this.saletype,
      this.balanceQuantityInstock,
      this.orderQuantity,
      this.quantityToDeliver,
      this.quantityToInvoice,
      this.productUom,
      this.productUnitPrice,
      this.taxes,
      this.discount,
      this.subtotal});

  final int? id;
  final int? orderId;
  final int? productId;
  final int? productName;
  final int? description;
  final int? saletype;
  final int? balanceQuantityInstock;
  final int? orderQuantity;
  final int? quantityToDeliver;
  final int? quantityToInvoice;
  final int? productUom;
  final int? productUnitPrice;
  final int? taxes;
  final int? discount;
  final int? subtotal;

  factory SaleOrderLine.fromJson(Map<String, dynamic> json) => SaleOrderLine(
        id: json['id'],
        orderId: json['orderId'],
        productId: json['productId'],
        productName: json['productName'],
        description: json['description'],
        saletype: json['saletype'],
        balanceQuantityInstock: json['balanceQuantityInstock'],
        orderQuantity: json['orderQuantity'],
        quantityToDeliver: json['quantityToDeliver'],
        quantityToInvoice: json['quantityToInvoice'],
        productUnitPrice: json['productUnitPrice'],
        productUom: json['productUom'],
        taxes: json['taxes'],
        discount: json['discount'],
        subtotal: json['subtotal'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['orderId'] = orderId;
    map['productId'] = productId;
    map['productName'] = productName;
    map['description'] = description;
    map['saletype'] = saletype;
    map['balanceQuantityInstock'] = balanceQuantityInstock;
    map['orderQuantity'] = orderQuantity;
    map['quantityToInvoice'] = quantityToInvoice;
    map['quantityToDeliver'] = quantityToDeliver;
    map['productUnitPrice'] = productUnitPrice;
    map['productUom'] = productUom;
    map['taxes'] = taxes;
    map['discount'] = discount;
    map['subtotal'] = subtotal;

    return map;
  }

  SaleOrderLine copyWith(
      {int? id,
      int? orderId,
      int? productId,
      int? productName,
      int? description,
      int? saletype,
      int? balanceQuantityInstock,
      int? orderQuantity,
      int? quantityToDeliver,
      int? quantityToInvoice,
      int? productUom,
      int? productUnitPrice,
      int? taxes,
      int? discount,
      int? subtotal}) {
    return SaleOrderLine(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        saletype: saletype ?? this.saletype,
        balanceQuantityInstock:
            balanceQuantityInstock ?? this.balanceQuantityInstock,
        orderQuantity: orderQuantity ?? this.orderQuantity,
        quantityToDeliver: quantityToDeliver ?? this.quantityToDeliver,
        quantityToInvoice: quantityToInvoice ?? this.quantityToInvoice,
        productUom: productUom ?? this.productUom,
        productUnitPrice: productUnitPrice ?? this.productUnitPrice,
        taxes: taxes ?? this.taxes,
        discount: discount ?? this.discount,
        subtotal: subtotal ?? this.subtotal);
  }
}
