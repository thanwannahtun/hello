class ProductLine {
  ProductLine({this.id, this.productId, this.quantity, this.productName});
  final int? id;
  final int? productId;
  final int? quantity;
  final String? productName;

  ProductLine copyWith(
      {int? id, int? productId, int? quantity, String? productName}) {
    return ProductLine(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        quantity: quantity ?? this.quantity);
  }

  factory ProductLine.fromJson(Map<String, dynamic> json) => ProductLine(
        id: json['id'] as int,
        productId: json['product_id'],
        productName: json['product_name'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['product_name'] = productName;
    map['product_id'] = productId;
    map['quantity'] = quantity;
    return map;
  }
}
