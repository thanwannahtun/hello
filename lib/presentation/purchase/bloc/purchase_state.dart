import 'package:equatable/equatable.dart';

abstract class PurchaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final List<Map<String, dynamic>> purchases;

  PurchaseLoaded({required this.purchases});

  @override
  List<Object> get props => [purchases];
}

class PurchaseError extends PurchaseState {
  final String message;

  PurchaseError({required this.message});

  @override
  List<Object> get props => [message];
}
