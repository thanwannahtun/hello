import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/presentation/inventory/bloc/inventory_state.dart';
import 'package:hello/models/inventory.dart';
import 'package:hello/presentation/inventory/repo/inventory_repo.dart';
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
    // on<InventoryUpdateCountEvent>(_inventoryUpdateCount);
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
          productId: event.inventory.productId,
          productName: event.inventory.productName,
          unit: event.inventory.unit);
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

    print(
        'fetched inventory Map  (${inventoryMap.map((e) => Inventory.fromJson(e))})');
    List<Inventory> inventoryList =
        inventoryMap.map((e) => Inventory.fromJson(e)).toList();
    return inventoryList.isEmpty ? [] : inventoryList;
  }

  FutureOr<void> _getAllInventoryLists(
      InventoryFetchEvent event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(status: BlocStatus.fetching, message: 'fetching...'));
    try {
      List<Inventory> inventoryList = await getInventoryLists();
      print('==============fetching inventory List from DB=================');
      print(inventoryList.map((e) => e.toJson()));
      emit(state.copyWith(
          status: BlocStatus.fetched, inventoryLists: inventoryList));
    } catch (e) {
      debugPrint('Error Fetching To Inventory ( $e ) ');
      emit(state.copyWith(
          status: BlocStatus.fetchefailed,
          error: 'Error Fetching To Inventory $e'));
    }
  }

/*
  FutureOr<void> _inventoryUpdateCount(
      InventoryUpdateCountEvent event, Emitter<InventoryState> emit) async {
    try {
      List<Inventory> inventoryList = await getInventoryLists();
      int index = inventoryList.indexWhere(
          (element) => element.productId == event.inventory.productId);
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
*/
  FutureOr<void> _inventoryAddOrUpdate(
      InventoryAddOrUpdateEvent event, Emitter<InventoryState> emit) async {
    try {
      final inventories = await getInventoryLists();
      int index = inventories.indexWhere(
          (inventory) => inventory.productId == event.inventory.productId);
      if (index == -1) {
        print(
            'addding ::::::::::::::::: to inventory list ${event.inventory.toJson()}');
        //add to Inventory
        await _inventoryRepo.addToInventory(values: event.inventory.toJson());
      } else {
        print(
            'updating onHand ::::::::::::::::: to inventory list ${event.inventory.toJson()}');
        //update to Invenotry
        await _inventoryRepo.updateCount(values: event.inventory.toJson());
      }
      // List<Inventory> inventoriesLists = await getInventoryLists();// error here
      List<Map<String, dynamic>> inventoryMap =
          await _inventoryRepo.getInventoryLists();
      List<Inventory> inventoriesLists =
          inventoryMap.map((e) => Inventory.fromJson(e)).toList();

      print(
          '(success) inventoresLists ::::::::::::::::: from database ${inventoriesLists.map((e) => e.toJson())}');
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