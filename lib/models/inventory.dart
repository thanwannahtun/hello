import 'package:hello/core/utils/entity.dart';

class Inventory extends Entity {
  Inventory(
      {this.id,
      this.productId,
      this.productName,
      this.unit,
      this.barcode,
      this.onHand})
      : super(entityId: id, entityName: productName);

  int? id;
  int? productId;
  String? productName;
  String? unit;
  String? barcode;
  double? onHand;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json['id'] as int,
        productId: json['productId'],
        productName: json['productName'] as String,
        unit: json['unit'],
        barcode: json['barcode'],
        onHand: json['onHand'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['productId'] = productId;
    map['productName'] = productName;
    map['unit'] = unit;
    map['barcode'] = barcode;
    map['onHand'] = onHand;
    return map;
  }

  Inventory copyWith(
      {int? id,
      int? productId,
      String? productName,
      String? unit,
      String? barcode,
      double? onHand}) {
    return Inventory(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        unit: unit ?? this.unit,
        barcode: barcode ?? this.barcode,
        onHand: onHand ?? this.onHand);
  }

  @override
  List<Object?> get props =>
      [id, productId, productName, unit, barcode, onHand];
}
