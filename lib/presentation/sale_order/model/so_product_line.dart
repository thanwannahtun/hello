import 'package:flutter/material.dart';

class SoProductLine {
  SoProductLine(
      {this.id,
      this.productId,
      this.productName,
      this.unitPrice,
      this.quantity,
      this.description,
      this.total});
  final int? id;
  final int? productId;
  final String? productName;
  final double? unitPrice;
  final double? quantity;
  final String? description;
  final double? total;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;

    return map;
  }

  factory SoProductLine.fromJson(Map<String, dynamic> json) => SoProductLine();

  SoProductLine copyWith(
      {int? id,
      int? productId,
      String? productName,
      double? unitPrice,
      double? quantity,
      String? description,
      double? total}) {
    return SoProductLine(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        unitPrice: unitPrice ?? this.unitPrice,
        quantity: quantity ?? this.quantity,
        description: description ?? this.description,
        total: total ?? this.total);
  }
}
