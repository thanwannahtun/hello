part of 'shopping_card_bloc.dart';

sealed class ShoppingCardEvent extends Equatable {
  const ShoppingCardEvent();

  @override
  List<Object> get props => [];
}

final class ShoppingCardAddProductEvent extends ShoppingCardEvent {
  final Product product;
  final int quantity;
  const ShoppingCardAddProductEvent(
      {required this.product, required this.quantity});
}

final class ShoppingCardRemoveProductEvent extends ShoppingCardEvent {
  final Product product;
  const ShoppingCardRemoveProductEvent({required this.product});
}

final class ShoppingCardUpdateQuantityEvent extends ShoppingCardEvent {
  final Product product;
  final int quantity;
  const ShoppingCardUpdateQuantityEvent(
      {required this.product, required this.quantity});
}
