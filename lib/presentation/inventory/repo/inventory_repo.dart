import 'package:flutter/material.dart';
import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/data/database/crud_table.dart';

class InventoryRepo {
  final CRUDTable _crudTable = CRUDTable.instance;

  Future<List<Map<String, dynamic>>> getInventoryLists() async {
    return _crudTable.readData(ConstantTables.inventoryTable);
  }

  Future<bool> addToInventory({required Map<String, dynamic> values}) async {
    try {
      int value =
          await _crudTable.insertData(ConstantTables.inventoryTable, values);
      return value > 0;
    } catch (e) {
      debugPrint('Error at Inventory Repo ( $e )');
      return false;
    }
  }

  Future<bool> updateCount({required Map<String, dynamic> values}) async {
    try {
      int value = await _crudTable.rawUpdate(
        'UPDATE ${ConstantTables.inventoryTable} SET on_hand = on_hand + 1 WHERE product_id = ?',
        [values['product_id']],
      );
      // int value = await _crudTable.updateData(
      //     table: ConstantTables.inventoryTable,
      //     values: values,
      //     where: 'product_id = ?',
      //     whereArgs: [values['prouct_id']]);

      return value > 0;
    } catch (e) {
      debugPrint('Error at Inventory Repo ( $e )');
      return false;
    }
  }
}
