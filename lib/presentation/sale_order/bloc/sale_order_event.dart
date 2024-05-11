part of 'sale_order_bloc.dart';

sealed class SaleOrderEvent extends Equatable {
  const SaleOrderEvent();

  @override
  List<Object> get props => [];
}

final class SaleOrderGetAllEvent extends SaleOrderEvent {}

final class SaleOrderCreateEvent extends SaleOrderEvent {
  final SaleOrder saleOrder;
  const SaleOrderCreateEvent({required this.saleOrder});
}
