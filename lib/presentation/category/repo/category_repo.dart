import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/models/category.dart';
import 'package:hello/models/product.dart';

class CategoryRepo {
  final CRUDTable _crudTable;
  CategoryRepo() : _crudTable = CRUDTable.instance;

  final String categoryTable = ConstantTables.categoryTable;

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    return await _crudTable.readData(categoryTable);
  }

  Future<Category?> addCategoryAndReturnCategory(
      {required Map<String, dynamic> values}) async {
    int value = await _crudTable.insertData(categoryTable, values);
    if (value > 0) {
      List<Map<String, dynamic>> categories = await _crudTable.readData(
          categoryTable,
          where: 'category_id = ?',
          whereArgs: [value]);

      if (categories.isNotEmpty) {
        return categories.map((e) => Category.fromJson(e)).toList().first;
      } else {
        return null;
      }
    }
    return null;
  }

  Future<bool> updateCategory({required Map<String, dynamic> values}) async {
    int value = await _crudTable.updateData(
        table: categoryTable,
        values: values,
        where: 'category_id = ?',
        whereArgs: [values['category_id']]);

    return value > 0;
  }

  Future<bool> deleteCategory({required int categoryId}) async {
    int value = await _crudTable.deleteData(categoryTable,
        where: 'category_id = ? ', whereArgs: [categoryId]);

    return value > 0;
  }
}
