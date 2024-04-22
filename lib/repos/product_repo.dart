import 'package:flutter/cupertino.dart';
import 'package:hello/database/constant_tables.dart';
import 'package:hello/database/crud_table.dart';
import 'package:hello/models/product.dart';

class ProductRepository {
  final CRUDTable _crudTable = CRUDTable.instance;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    return await _crudTable.readData(ConstantTables.productTable);
  }

  Future<bool> addProduct(Map<String, dynamic> values) async {
    debugPrint(
        '====  ========== productName ${values['product_name']} === =========  ===');
    try {
      int value =
          await _crudTable.insertData(ConstantTables.productTable, values);
      return value > 0;
    } catch (e) {
      debugPrint('error =>  $e');
      return false;
    }
  }

  Future<bool> updateProduct({required Product product}) async {
    // int value = await _crudTable.updateData(
    //     table: ConstantTables.productTable, values: product.toJson());
    int v = await _crudTable.updateData2(
        ConstantTables.productTable, product.toJson());
    return v > 0;
  }

  Future<bool> deleteProduct({required Product product}) async {
    int value = await _crudTable.deleteData(ConstantTables.productTable,
        where: ' product_id = ?', whereArgs: [product.productId]);
    return value > 0;
  }
}
