class Product {
  int? id;
  String? name;
  String? unit;
  String? barcode;

  Product({
    this.id,
    this.name,
    this.unit,
    this.barcode,
  });

  Product copyWith({
    int? id,
    String? name,
    String? unit,
    String? barcode,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      barcode: barcode ?? this.barcode,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        name: json['name'] as String,
        unit: json['unit'],
        barcode: json['barcode'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['unit'] = unit;
    map['barcode'] = barcode;
    return map;
  }

  // @override
  // String toString() {
  //   return "Product($id,$name,$unit,$barcode)";
  // }

  @override
  String toString() {
    return 'Product{id=$id, name=$name, unit=$unit, barcode=$barcode}';
  }
}
