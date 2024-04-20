class Product {
  int? productId;
  String? productName;
  String? unit;
  String? barcode;

  Product({
    this.productId,
    this.productName,
    this.unit,
    this.barcode,
  });

  Product copyWith({
    int? productId,
    String? productName,
    String? unit,
    String? barcode,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unit: unit ?? this.unit,
      barcode: barcode ?? this.barcode,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json['product_id'] as int,
        productName: json['product_name'] as String,
        unit: json['unit'],
        barcode: json['barcode'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['unit'] = unit;
    map['barcode'] = barcode;
    return map;
  }
}
