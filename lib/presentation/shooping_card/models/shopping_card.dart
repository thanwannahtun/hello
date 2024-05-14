import 'package:equatable/equatable.dart';
import 'package:hello/presentation/shooping_card/models/product_line.dart';

class ShoppingCard extends Equatable {
  const ShoppingCard({this.id, this.productLines});
  final int? id;
  final List<ProductLine>? productLines;

  ShoppingCard copyWith({int? id, List<ProductLine>? productLines}) {
    return ShoppingCard(
        id: id ?? this.id, productLines: productLines ?? this.productLines);
  }

  factory ShoppingCard.fromJson(Map<String, dynamic> json) {
    final List<ProductLine> productlines = [];

    if (json['productLines'] != null) {
      for (var line in json['productLines']) {
        productlines.add(ProductLine.fromJson(line));
      }
    }
    return ShoppingCard(
      id: json['id'],
      productLines: productlines,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['productLines'] = productLines;
    return map;
  }

  @override
  List<Object?> get props => [id, productLines];
}
