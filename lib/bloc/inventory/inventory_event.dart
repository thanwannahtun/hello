part of 'inventory_bloc.dart';

// @immutable
sealed class InventoryEvent {}

class InventoryAddEvent extends InventoryEvent {
  final Inventory inventory;

  InventoryAddEvent(this.inventory);
}

class InventoryUpdateCountEvent extends InventoryEvent {
  final Inventory inventory;
  InventoryUpdateCountEvent(this.inventory);
}

class InventoryFetchEvent extends InventoryEvent {}

class InventoryRemoveEvent extends InventoryEvent {
  final Inventory inventory;
  InventoryRemoveEvent(this.inventory);
}

class InventoryAddOrUpdateEvent extends InventoryEvent {
  final Inventory inventory;
  InventoryAddOrUpdateEvent(this.inventory);
}
