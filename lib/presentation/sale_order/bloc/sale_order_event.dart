part of 'sale_order_bloc.dart';

sealed class SaleOrderEvent extends Equatable {
  const SaleOrderEvent();

  @override
  List<Object> get props => [];
}

final class SaleOrderGetAllEvent extends SaleOrderEvent {}

final class SaleOrderCreateEvent extends SaleOrderEvent {
  final SaleOrder saleOrder;
  // final List<SaleOrderLine> orderLines;
  const SaleOrderCreateEvent({
    required this.saleOrder,
    //  required this.orderLines
  });
}

final class AddOrderLineEvent extends SaleOrderEvent {
  final SaleOrderLine orderLine;
  const AddOrderLineEvent({required this.orderLine});
}

final class RemoveOrderLineEvent extends SaleOrderEvent {
  final SaleOrderLine orderLine;
  const RemoveOrderLineEvent({required this.orderLine});
}

final class UpdateOrderLineEvent extends SaleOrderEvent {
  final SaleOrderLine orderLine;
  const UpdateOrderLineEvent({required this.orderLine});
}

final class AddCurrentOrderLineEvent extends SaleOrderEvent {
  final int saleOrderId;
  final List<SaleOrderLine> orderLines;
  const AddCurrentOrderLineEvent(
      {required this.saleOrderId, required this.orderLines});
}
