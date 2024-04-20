class Inventory {
  Inventory(
      {this.inventoryId,
      this.productId,
      this.productName,
      this.unit,
      this.onHand});

  int? inventoryId;
  int? productId;
  String? productName;
  String? unit;
  double? onHand;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        inventoryId: json['inventory_id'] as int,
        productId: json['product_id'] as int,
        productName: json['product_name'] as String,
        unit: json['unit'],
        onHand: json['on_hand'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['inventory_id'] = inventoryId;
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['unit'] = unit;
    map['on_hand'] = onHand;
    return map;
  }

  Inventory copyWith(
      {int? inventoryId,
      int? productId,
      String? productName,
      String? unit,
      double? onHand}) {
    return Inventory(
        inventoryId: inventoryId ?? this.inventoryId,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        unit: unit ?? this.unit,
        onHand: onHand ?? this.onHand);
  }
}
