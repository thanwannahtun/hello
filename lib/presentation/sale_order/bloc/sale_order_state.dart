part of 'sale_order_bloc.dart';

sealed class SaleOrderState extends Equatable {
  const SaleOrderState();
  
  @override
  List<Object> get props => [];
}

final class SaleOrderInitial extends SaleOrderState {}
