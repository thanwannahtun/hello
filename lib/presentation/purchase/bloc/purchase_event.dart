import 'package:equatable/equatable.dart';

abstract class PurchaseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPurchases extends PurchaseEvent {}

class AddPurchase extends PurchaseEvent {
  final int productId;
  final int vendorId;
  final int quantity;
  final DateTime purchaseDate;

  AddPurchase({
    required this.productId,
    required this.vendorId,
    required this.quantity,
    required this.purchaseDate,
  });

  @override
  List<Object> get props => [productId, vendorId, quantity, purchaseDate];
}
