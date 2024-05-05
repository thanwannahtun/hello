import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/presentation/shooping_card/models/product_line.dart';
import 'package:hello/presentation/shooping_card/models/shopping_card.dart';

import '../../../models/product.dart';

class ShoppingCardRepo {
  final shoppingCardTable = ConstantTables.shoppingCardTable;
  final CRUDTable _crudTable;
  ShoppingCardRepo() : _crudTable = CRUDTable.instance;

  Future<ProductLine?> addToCard(
      {required Product product, required int quantity}) async {
    try {
      int value =
          await _crudTable.insertData(shoppingCardTable, product.toJson());
      if (value > 0) {
        Map<String, dynamic> line =
            await _crudTable.getDataById(shoppingCardTable, value);
        return ProductLine.fromJson(line);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeFromCard({required Product product}) async {
    try {
      int value = await _crudTable.deleteData(shoppingCardTable,
          where: ' product_id = ? ', whereArgs: [product.productId]);
      return value > 0;
    } catch (e) {
      return false;
    }
  }

  // updateQuantity({required int productId, required int quantity}) async {

  updateQuantity({required Product product}) async {
    await _crudTable.updateData(
        table: shoppingCardTable,
        values: product.toJson(),
        where: 'product_id = ?',
        whereArgs: [product.productId]);
  }
}
