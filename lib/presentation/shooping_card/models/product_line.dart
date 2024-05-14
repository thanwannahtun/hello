import 'package:hello/core/utils/entity.dart';

class ProductLine extends Entity {
  const ProductLine(
      {required this.shoppingCardId,
      this.id,
      this.productId,
      this.quantity,
      this.productName})
      : super(entityId: id, entityName: productName);

  final int? id;
  final int shoppingCardId;
  final int? productId;
  final int? quantity;
  final String? productName;

  ProductLine copyWith(
      {int? id,
      int? shoppingCardId,
      int? productId,
      int? quantity,
      String? productName}) {
    return ProductLine(
        id: id ?? this.id,
        shoppingCardId: shoppingCardId ?? this.shoppingCardId,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        quantity: quantity ?? this.quantity);
  }

  factory ProductLine.fromJson(Map<String, dynamic> json) => ProductLine(
        id: json['id'] as int,
        shoppingCardId: json['shoppingCardId'] as int,
        productId: json['productId'],
        productName: json['productName'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['shoppingCardId'] = shoppingCardId;
    map['productName'] = productName;
    map['productId'] = productId;
    map['quantity'] = quantity;
    return map;
  }

  @override
  List<Object?> get props =>
      [id, shoppingCardId, productId, quantity, productName];
}

/*
  try {
      var results =
          await conn.query('SELECT * FROM shopping_cards WHERE id = ?', [cardId]);
      if (results.isNotEmpty) {
        var card = results.first;
        var productLines = await ProductLine.getProductLinesByCardId(cardId);
        // check extra ... here 
        return ShoppingCard(
          id: card['id'],
          productLines: productLines,
        );
      }
    }
*/