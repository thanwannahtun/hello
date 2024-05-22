import 'package:flutter/material.dart';
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

import 'package:hello/core/utils/entity.dart';

class SaleOrderLine extends Entity {
  const SaleOrderLine(
      {this.id,
      this.orderId,
      this.productId,
      this.productName,
      this.description,
      this.saletype,
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
  final String? productName;
  final String? description;
  final String? saletype;
  final int? orderQuantity;
  final double? quantityToDeliver;
  final double? quantityToInvoice;
  final String? productUom;
  final double? productUnitPrice;
  final double? taxes;
  final double? discount;
  final double? subtotal;

  factory SaleOrderLine.fromJson(Map<String, dynamic> json) => SaleOrderLine(
        id: json['id'],
        orderId: json['orderId'],
        productId: json['productId'],
        productName: json['productName'],
        description: json['description'],
        saletype: json['saletype'],
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

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        productName,
        description,
        saletype,
        orderQuantity,
        quantityToDeliver,
        quantityToInvoice,
        productUom,
        productUnitPrice,
        taxes,
        discount,
        subtotal
      ];
  SaleOrderLine copyWith(
      {int? id,
      int? orderId,
      int? productId,
      String? productName,
      String? description,
      String? saletype,
      int? orderQuantity,
      double? quantityToDeliver,
      double? quantityToInvoice,
      String? productUom,
      double? productUnitPrice,
      double? taxes,
      double? discount,
      double? subtotal}) {
    return SaleOrderLine(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        saletype: saletype ?? this.saletype,
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
