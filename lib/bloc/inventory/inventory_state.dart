import 'package:equatable/equatable.dart';
import 'package:hello/bloc/bloc_state/bloc_status.dart';
import 'package:hello/models/inventory.dart';

class InventoryState extends Equatable {
  const InventoryState(
      {required this.status,
      required this.inventoryLists,
      required this.error,
      required this.message});

  final BlocStatus status;
  final List<Inventory> inventoryLists;
  final String error;
  final String message;
  InventoryState copyWith(
      {BlocStatus? status,
      List<Inventory>? inventoryLists,
      String? error,
      String? message}) {
    return InventoryState(
        status: status ?? this.status,
        inventoryLists: inventoryLists ?? this.inventoryLists,
        error: error ?? this.error,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [status, error, message, inventoryLists];
}
