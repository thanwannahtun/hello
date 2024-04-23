part of 'inventory_bloc.dart';

// @immutable
sealed class InventoryEvent {}

class InventoryAddEvent extends InventoryEvent {
  final Product product;

  InventoryAddEvent(this.product);
}

class InventoryUpdateCountEvent extends InventoryEvent {
  final Product product;
  InventoryUpdateCountEvent(this.product);
}

class InventoryFetchEvent extends InventoryEvent {}

class InventoryRemoveEvent extends InventoryEvent {
  final Product product;
  InventoryRemoveEvent(this.product);
}

class InventoryAddOrUpdateEvent extends InventoryEvent {
  final Product product;
  InventoryAddOrUpdateEvent(this.product);
}