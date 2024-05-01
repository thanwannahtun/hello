import 'package:sqflite/sqflite.dart';
import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/utils/constant_culumns.dart';

class TableCreator {
  static final List<String> _tables = [
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.productTable} (
      ${ConstantCulumn.productId} INTEGER PRIMARY KEY, 
      ${ConstantCulumn.productName} TEXT NOT NULL, 
      ${ConstantCulumn.unit} TEXT, 
      ${ConstantCulumn.barcode} TEXT 
    )''',
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.inventoryTable} (
      ${ConstantCulumn.inventoryId} INTEGER PRIMARY KEY, 
      ${ConstantCulumn.productId} INTEGER, 
      ${ConstantCulumn.productName} TEXT NOT NULL, 
      ${ConstantCulumn.unit} TEXT,
      ${ConstantCulumn.barcode} TEXT,
      ${ConstantCulumn.onHand} REAL
    )''',
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.categoryTable} (
      ${ConstantCulumn.categoryId} INTEGER PRIMARY KEY,
      ${ConstantCulumn.categoryName} TEXT NOT NULL,
      ${ConstantCulumn.parentId} INTEGER,
      ${ConstantCulumn.parentName} TEXT
    )'''
  ];

// (1) table inventory_table has no column named barcode in "INSERT INTO inventory_table (product_id, product_name, unit, barcode) VALUES (?, ?, ?, ?)"
  static Future<void> createTables(Database db) async {
    for (var table in _tables) {
      await db.execute(table);
    }
  }

  static Future<void> updateTables(Database db) async {
    for (var table in _tables) {
      await db.execute(table);
      // UPDATE QUERY
    }
  }
}
