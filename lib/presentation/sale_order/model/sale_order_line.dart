class SaleOrderLine {
  SaleOrderLine(
      {this.id,
      this.customerId,
      this.productId,
      this.productName,
      this.price,
      this.quantity});

  final int? id;
  final int? customerId;
  final int? productId;
  final String? productName;
  final double? price;
  final double? quantity;

  factory SaleOrderLine.fromJson(Map<String, dynamic> json) => SaleOrderLine();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;

    return map;
  }

  SaleOrderLine copyWith(
      {int? id,
      int? customerId,
      String? customerName,
      int? productId,
      double? price,
      double? quantity}) {
    return SaleOrderLine(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        productId: productId ?? this.productId,
        productName: productName ?? productName,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity);
  }
}
/// Usage 
/// finter by this.customerId
/// select * from sale_order_line where customer_id = this.customerId