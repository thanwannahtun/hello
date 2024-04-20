part of 'product_bloc.dart';

class ProductState extends Equatable {
  final BlocStatus status;
  final String error;
  final String message;
  final List<Product> products;

  const ProductState(
      {required this.status,
      required this.error,
      required this.message,
      required this.products});

  @override
  List<Object> get props => [];
  ProductState copyWith(
      {BlocStatus? status,
      String? error,
      String? message,
      List<Product>? products}) {
    return ProductState(
        status: status ?? this.status,
        error: error ?? this.error,
        message: message ?? this.message,
        products: products ?? this.products);
  }

  @override
  String toString() {
    print('------- state => ${status.name}');
    return super.toString();
  }
}
