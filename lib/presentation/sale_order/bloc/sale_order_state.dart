part of 'sale_order_bloc.dart';

class SaleOrderState extends Equatable {
  const SaleOrderState(
      {required this.status, required this.saleOrders, this.error});

  final BlocStatus status;
  final List<SaleOrder> saleOrders;
  final String? error;

  SaleOrderState copyWith(
      {BlocStatus? status, List<SaleOrder>? saleOrders, String? error}) {
    return SaleOrderState(
        status: status ?? this.status,
        saleOrders: saleOrders ?? this.saleOrders,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, saleOrders, error];
}
