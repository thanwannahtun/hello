part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductFetchEvent extends ProductEvent {}

class ProductAddEvent extends ProductEvent {
  final Product product;
  ProductAddEvent(this.product);
}

class ProductUpdateEvent extends ProductEvent {
  final Product product;
  ProductUpdateEvent(this.product);
}

class ProductDeleteEvent extends ProductEvent {
  final int id;
  ProductDeleteEvent(this.id);
}
