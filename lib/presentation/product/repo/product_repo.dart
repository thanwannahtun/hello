import 'package:flutter/cupertino.dart';
import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/models/product.dart';

class ProductRepository {
  final CRUDTable _crudTable = CRUDTable.instance;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    return await _crudTable.readData(ConstantTables.productTable);
  }

  Future<bool> addProduct(Map<String, dynamic> values) async {
    try {
      int value =
          await _crudTable.insertData(ConstantTables.productTable, values);
      return value > 0;
    } catch (e) {
      debugPrint('error =>  $e');
      return false;
    }
  }

  Future<Product?> addProductAndGetProduct(Map<String, dynamic> values) async {
    int value =
        await _crudTable.insertData(ConstantTables.productTable, values);
    if (value > 0) {
      List<Map<String, dynamic>> products = await _crudTable.readData(
          ConstantTables.productTable,
          where: ' id = ?',
          whereArgs: [value]);
      if (products.isNotEmpty) {
        return products.map((e) => Product.fromJson(e)).toList().first;
      }
    } else {
      return null;
    }
    return null;
  }

  Future<bool> updateProduct({required Product product}) async {
    int v = await _crudTable.updateData(
        table: ConstantTables.productTable,
        values: product.toJson(),
        where: ' id = ?',
        whereArgs: [product.id]);
    return v > 0;
  }

  Future<bool> deleteProduct({required int id}) async {
    int value = await _crudTable.deleteData(ConstantTables.productTable,
        where: '  id = ?', whereArgs: [id]);
    return value > 0;
  }
}
