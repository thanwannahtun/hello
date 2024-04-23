import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:hello/bloc/bloc_state/bloc_status.dart';
import 'package:hello/bloc/inventory/inventory_state.dart';
import 'package:hello/models/inventory.dart';
import 'package:hello/models/product.dart';
import 'package:hello/repos/inventory_repo.dart';
part 'inventory_event.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepo _inventoryRepo;

  InventoryBloc()
      : _inventoryRepo = InventoryRepo(),
        super(const InventoryState(
            status: BlocStatus.initial,
            inventoryLists: [],
            error: '',
            message: '')) {
    on<InventoryAddEvent>(_addToInventory);
    on<InventoryFetchEvent>(_getAllInventoryLists);
    on<InventoryUpdateCountEvent>(_inventoryUpdateCount);
    on<InventoryAddOrUpdateEvent>(_inventoryAddOrUpdate);
  }

  FutureOr<void> _addToInventory(
      InventoryAddEvent event, Emitter<InventoryState> emit) async {
    // emit(state.copyWith(status: BlocStatus.adding, message: 'adding '));

/*
  int? inventoryId;
  int? productId;
  String? productName;
  String? unit;
  double? onHand;
*/

    try {
      Inventory inventory = Inventory(
          productId: event.product.productId,
          productName: event.product.productName,
          unit: event.product.unit);
      bool isAdded =
          await _inventoryRepo.addToInventory(values: inventory.toJson());
      if (!isAdded) {
        emit(state.copyWith(
            status: BlocStatus.addfailed,
            error: 'Failed Adding To Inventory!'));
      }
      emit(state.copyWith(
          status: BlocStatus.added, message: 'successfully added!'));
      // emit.call(state.copyWith(status: BlocStatus.added));
    } catch (e) {
      debugPrint('Error Adding To Inventory ( $e ) ');
      emit(state.copyWith(
          status: BlocStatus.addfailed, error: 'Error Adding To Inventory $e'));
    }
  }

  Future<List<Inventory>> getInventoryLists() async {
    List<Map<String, dynamic>> inventoryMap =
        await _inventoryRepo.getInventoryLists();
    debugPrint('Fetched inventoryMap =: $inventoryMap');

    List<Inventory> inventoryList =
        inventoryMap.map((e) => Inventory.fromJson(e)).toList();
    return inventoryList.isEmpty ? [] : inventoryList;
  }

  FutureOr<void> _getAllInventoryLists(
      InventoryFetchEvent event, Emitter<InventoryState> emit) async {
    // emit(state.copyWith(status: BlocStatus.fetching, message: 'fetching...'));
    try {
      List<Inventory> inventoryList = await getInventoryLists();
      print('===============================');
      print(inventoryList);
      emit(state.copyWith(
          status: BlocStatus.fetched, inventoryLists: inventoryList));
    } catch (e) {
      debugPrint('Error Fetching To Inventory ( $e ) ');
      emit(state.copyWith(
          status: BlocStatus.fetchefailed,
          error: 'Error Fetching To Inventory $e'));
    }
  }

  FutureOr<void> _inventoryUpdateCount(
      InventoryUpdateCountEvent event, Emitter<InventoryState> emit) async {
    try {
      List<Inventory> inventoryList = await getInventoryLists();
      int index = inventoryList.indexWhere(
          (element) => element.productId == event.product.productId);
      // if (index != -1) {
      //   inventoryList[index].onHand = inventoryList[index].onHand! + 1;
      // }
      if (index != -1) {
        bool isUpdated = await _inventoryRepo.updateCount(
            values: inventoryList[index].toJson());
        if (isUpdated) {
          emit(state.copyWith(
              status: BlocStatus.updated, message: 'successfully updated'));
        } else {
          emit(state.copyWith(
              status: BlocStatus.updatefailed,
              error: 'Failed updating Count '));
        }
      }
    } catch (e) {
      debugPrint('Error Updating To Inventory ( $e ) ');
      emit(state.copyWith(
          status: BlocStatus.updatefailed,
          error: 'Error Updating To Inventory $e'));
    }
  }

  FutureOr<void> _inventoryAddOrUpdate(
      InventoryAddOrUpdateEvent event, Emitter<InventoryState> emit) async {
    try {
      final inventories = await getInventoryLists();
      int index = inventories.indexWhere(
          (inventory) => inventory.productId == event.product.productId);
      if (index == -1) {
        //add to Inventory
        await _inventoryRepo.addToInventory(values: event.product.toJson());
      } else {
        //update to Invenotry
        await _inventoryRepo.updateCount(values: event.product.toJson());
      }
      final inventoriesLists = await getInventoryLists();
      print('added success');
      emit(state.copyWith(
          status: BlocStatus.fetched, inventoryLists: inventoriesLists));
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.addfailed,
          error: 'Error at InventoryAddOrUpdateEvent '));
    }
  }
}

/*

scan the barcode (user)

add scan event to the inventory Bloc 

get all inventoryList from the repo

if(scanned barcode exitst in inventorylist){
  update the inventory table 

  excute UPDATE query for count (scanned product's count)
}else {
  throw Error 'Barcode Not Found!'
}



*/