class Purchase {
  Purchase(
      {this.id,
      this.productId,
      this.vendorId,
      this.quantity,
      this.purchaseDate});
  int? id;
  int? productId;
  int? vendorId;
  int? quantity;
  DateTime? purchaseDate;

  //   'quantity': event.quantity,
  //   'purchase_date': event.purchase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'vendorId': vendorId,
      'quantity': quantity,
      'purchaseDate': purchaseDate
    };
  }
}
