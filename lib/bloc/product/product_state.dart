part of 'product_bloc.dart';

final class ProductState extends Equatable {
  const ProductState(
      {required this.products, required this.status, this.error});

  final List<Product> products;
  final String? error;
  final BlocStatus status;
  ProductState copyWith(
      {List<Product>? products, String? error, BlocStatus? status}) {
    return ProductState(
        products: products ?? this.products,
        error: error ?? this.error,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [products, error, status];
}
