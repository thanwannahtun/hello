import 'package:sqflite/sqflite.dart';
import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/utils/constant_culumns.dart';

class TableCreator {
  static final List<String> _tables = [
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.productTable} (
      ${ConstantCulumn.id} INTEGER PRIMARY KEY, 
      ${ConstantCulumn.name} TEXT NOT NULL, 
      ${ConstantCulumn.unit} TEXT, 
      ${ConstantCulumn.supplierId} INTEGER, 
      ${ConstantCulumn.barcode} TEXT 
    )''',
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.inventoryTable} (
      ${ConstantCulumn.id} INTEGER PRIMARY KEY, 
      ${ConstantCulumn.productId} INTEGER, 
      ${ConstantCulumn.productName} TEXT NOT NULL, 
      ${ConstantCulumn.unit} TEXT,
      ${ConstantCulumn.barcode} TEXT,
      ${ConstantCulumn.onHand} REAL
    )''',
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.categoryTable} (
      ${ConstantCulumn.id} INTEGER PRIMARY KEY,
      ${ConstantCulumn.name} TEXT NOT NULL,
      ${ConstantCulumn.parentId} INTEGER,
      ${ConstantCulumn.parentName} TEXT
    )''',
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.shoppingCardTable} (
      ${ConstantCulumn.id} INTEGER PRIMARY KEY
    )''',
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.productLineTable} (
      ${ConstantCulumn.id} INTEGER PRIMARY KEY,
      ${ConstantCulumn.shoppingCardId} INTEGER,
      ${ConstantCulumn.productId} INTEGER NOT NULL,
      ${ConstantCulumn.productName} TEXT NOT NULL,
      ${ConstantCulumn.quantity} INTEGER NOT NULL
    )''',
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.saleOrderTable} (
      ${ConstantCulumn.id} INTEGER PRIMARY KEY,
      ${ConstantCulumn.soNo} TEXT NOT NULL UNIQUE,
      ${ConstantCulumn.orderType} TEXT,
      ${ConstantCulumn.orderDate} TEXT NOT NULL,
      ${ConstantCulumn.deliveryStatus} TEXT,
      ${ConstantCulumn.salePersonId} INTEGER NOT NULL,
      ${ConstantCulumn.customerId} INTEGER NOT NULL,
      ${ConstantCulumn.customerName} TEXT,
      ${ConstantCulumn.salePersonName} TEXT,
      ${ConstantCulumn.township} TEXT,
      ${ConstantCulumn.ward} TEXT,
      ${ConstantCulumn.phone} TEXT
    )''',
    '''CREATE TABLE IF NOT EXISTS ${ConstantTables.saleOrderLineTable} (
      ${ConstantCulumn.id} INTEGER PRIMARY KEY,
      ${ConstantCulumn.orderId} INTEGER NOT NULL,
      ${ConstantCulumn.productId} INTEGER NOT NULL,
      ${ConstantCulumn.productName} TEXT NOT NULL,
      ${ConstantCulumn.description} TEXT,
      ${ConstantCulumn.saleType} TEXT,
      ${ConstantCulumn.orderQuantity} INTEGER NOT NULL,
      ${ConstantCulumn.quantityToDeliver} REAL NOT NULL,
      ${ConstantCulumn.quantityToInvoice} REAL,
      ${ConstantCulumn.productUom} TEXT NOT NULL,
      ${ConstantCulumn.productUnitPrice} REAL NOT NULL,
      ${ConstantCulumn.taxes} REAL,
      ${ConstantCulumn.discount} REAL,
      ${ConstantCulumn.subtotal} REAL
    )'''
  ];

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

/*
// static const String saleOrderLineTable = "sale_order_line_table";


INSERT INTO ${ConstantTables.saleOrderTable}
  (${ConstantColumn.soNo}, ${ConstantColumn.orderType}, ${ConstantColumn.orderDate},
  ${ConstantColumn.deliveryStatus}, ${ConstantColumn.salePerson},
  ${ConstantColumn.salePersonId}, ${ConstantColumn.customerId}, ${ConstantColumn.customerName},
  ${ConstantColumn.salePersonName}, ${ConstantColumn.township}, ${ConstantColumn.ward},
  ${ConstantColumn.phone})
VALUES ((SELECT COALESCE(MAX(${ConstantColumn.soNo}), 0) + 1 FROM ${ConstantTables.saleOrderTable}), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)

*/