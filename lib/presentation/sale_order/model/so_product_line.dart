import 'package:flutter/material.dart';
import 'package:hello/core/utils/entity.dart';

class SoProductLine extends Entity {
  const SoProductLine(
      {this.id,
      this.productId,
      this.productName,
      this.unitPrice,
      this.quantity,
      this.description,
      this.total})
      : super(entityId: id, entityName: productName);
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

  factory SoProductLine.fromJson(Map<String, dynamic> json) =>
      const SoProductLine();

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

  @override
  List<Object?> get props =>
      [id, productId, productName, unitPrice, quantity, description, total];
}
