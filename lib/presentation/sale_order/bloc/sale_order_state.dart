part of 'sale_order_bloc.dart';

class SaleOrderState extends Equatable {
  const SaleOrderState(
      {required this.status,
      required this.saleOrders,
      required this.orderLines,
      this.error});

  final BlocStatus status;
  final List<SaleOrder> saleOrders;
  final List<SaleOrderLine> orderLines;
  final String? error;

  SaleOrderState copyWith(
      {BlocStatus? status,
      List<SaleOrder>? saleOrders,
      List<SaleOrderLine>? orderLines,
      String? error}) {
    return SaleOrderState(
        status: status ?? this.status,
        saleOrders: saleOrders ?? this.saleOrders,
        orderLines: orderLines ?? this.orderLines,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, saleOrders, orderLines, error];
}
