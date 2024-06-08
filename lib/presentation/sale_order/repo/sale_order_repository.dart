import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/presentation/sale_order/model/sale_order_line.dart';
import 'package:sqflite/sqflite.dart';

class SaleOrderRepository {
  final CRUDTable _crudTable;

  SaleOrderRepository() : _crudTable = CRUDTable.instance;

  final _saleOrderTable = ConstantTables.saleOrderTable;
  final _saleOrderLineTable = ConstantTables.saleOrderLineTable;

  /// [getAllSaleOrders]
  FutureOr<List<SaleOrder>> getAllSaleOrders() async {
    final saleOrdeList = await _crudTable.readData(_saleOrderTable);
    List<SaleOrder> saleOrders = [];
    if (saleOrdeList.isNotEmpty) {
      for (var saleOrder in saleOrdeList) {
        final saleOrderLines = await _crudTable.readData(_saleOrderLineTable,
            where: ' orderId = ? ', whereArgs: [saleOrder['id']]);
        saleOrder['saleOrderLines'] = saleOrderLines;
        saleOrders.add(SaleOrder.fromJson(saleOrder));
      }
      return saleOrders;
    }
    return saleOrders;
  }

  /// [getSaleOrderById]
  FutureOr<SaleOrder?> getSaleOrderById({required int id}) async {
    final saleOrdersMap = await _crudTable
        .readData(_saleOrderTable, where: ' id = ? ', whereArgs: [id]);
    if (saleOrdersMap.isNotEmpty) {
      final saleOrderLines = await _crudTable.readData(_saleOrderLineTable,
          where: ' orderId = ? ', whereArgs: [id]);
      saleOrdersMap.first['saleOrderLines'] = saleOrderLines;
      return SaleOrder.fromJson(saleOrdersMap.first);
    }
    return null;
  }

  /// [addSaleOrderAndGetAddedOrder]
  FutureOr<SaleOrder?> addSaleOrderAndGetAddedOrder(
      {required SaleOrder saleOrder}) async {
    try {
      int id = await _crudTable.insertData(_saleOrderTable, saleOrder.toJson());

      List<Map<String, dynamic>> ordersMap = await _crudTable
          .readData(_saleOrderTable, where: 'id = ?', whereArgs: [id]);
      if (ordersMap.isNotEmpty) {
        return SaleOrder.fromJson(ordersMap.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// [updateSaleOrder] updatin delivery status || order state , etc.. given by Bloc using copyWith()
  FutureOr<bool> updateSaleOrder(
      {required int id, required SaleOrder saleOrder}) async {
    int value = await _crudTable.updateData(
        table: _saleOrderTable,
        values: saleOrder.toJson(),
        where: '  id = ? ',
        whereArgs: [id]);

    return value > 0;
  }

  /// [deleteSalesOrder]
  FutureOr<bool> deleteSalesOrder({required int id}) async {
    /// firstly delete all saleOrderLines corresponding with saleOrder by [ id ]
    int valueforline = await _crudTable
        .deleteData(_saleOrderLineTable, where: 'orderId = ?', whereArgs: [id]);

    /// sencondly delete the saleOrder by [ id ]
    int valueforSO = await _crudTable
        .deleteData(_saleOrderTable, where: ' id = ?', whereArgs: [id]);
    debugPrint(
        ' saleOrderLineDeleted ( $valueforline ) , saleOrderDeleted ( $valueforSO ) ');
    return valueforSO > 0;
  }

  /*
  
  1. add orderLine by one by soId given by Route or state.current saleOrder.id

  --- < or > --

  2. add orderLine by one without knowing their saleOrder id 
    and then create a saleOrder ( current SO ) with the list of saleOrderLines created and then save to the DB

  --- < with > ---

  3. declare  List<SaleOrder> ( orderLists ) , saleOrder ( current so ) , List<SaleOrderLine> ( current line lists ),

  */

  /// [addOrderline]

  addOrderline({required SaleOrderLine line}) async {}

  addOrderlines({required int soId, required List<SaleOrderLine> lines}) async {
    for (SaleOrderLine line in lines) {
      line.copyWith(orderId: soId);
      await _crudTable.insertByTransition((txn) async {
        await txn.insert(_saleOrderLineTable, line.toJson());
      });
    }
  }

  addOrderLinesByBatch(
      {required int orderId, required List<SaleOrderLine> lines}) async {
    await _crudTable.insertByBatch((batch) async {
      try {
        for (var line in lines) {
          line.copyWith(orderId: orderId);
          batch.insert(_saleOrderLineTable, line.toJson());
        }
        batch.commit();
        return;
      } catch (e) {
        return;
      }
    });
  }

  // removeOrderLines () async {

  // }
}
