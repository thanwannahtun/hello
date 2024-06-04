import 'package:flutter/foundation.dart';
import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/presentation/sale_order/model/sale_order_line.dart';

class SaleOrderRepo {
  final CRUDTable _crudTable;

  SaleOrderRepo() : _crudTable = CRUDTable.instance;

  final saleOrderTable = ConstantTables.saleOrderTable;
  final saleOrderLineTable = ConstantTables.saleOrderLineTable;
  // Future<List<SaleOrder>> getAllSaleOrders() async {
  //   List<SaleOrder> saleOrders = [];
  //   List<Map<String, dynamic>> saleOrdersMap =
  //       await _crudTable.readData(saleOrderTable);
  //   for (var order in saleOrdersMap) {
  //     saleOrders.add(SaleOrder.fromJson(order));
  //   }
  //   return saleOrders;
  // }

  Future<List<SaleOrder>> getAllSaleOrders() async {
    List<SaleOrder> saleOrders = [];

    List<Map<String, dynamic>> saleOrderMap =
        await _crudTable.readData(saleOrderTable);
    if (saleOrderMap.isEmpty) return saleOrders;

    for (var saleOrder in saleOrderMap) {
      /// start filter by object.id saleOrder['id']
      List<Map<String, dynamic>> orderLineMap = await _crudTable.readData(
          saleOrderLineTable,
          where: ' id = ?',
          whereArgs: [saleOrder['id'] as int]);
      List<SaleOrderLine> saleOrderLines =
          orderLineMap.map((e) => SaleOrderLine.fromJson(e)).toList();

      /// end
      saleOrders.add(SaleOrder(
          id: saleOrder['id'],
          customerName: saleOrder['customerName'],
          customerId: saleOrder['customerId'],
          deliveryStatus: saleOrder['deliveryStatus'],
          orderDate: saleOrder['orderDate'],
          orderType: saleOrder['orderType'],
          phone: saleOrder['phone'],
          saleOrderLines: saleOrderLines,
          salePersonId: saleOrder['salePersonId'],
          salePersonName: saleOrder['salePersonName'],
          soNo: saleOrder['soNo'],
          township: saleOrder['township'],
          ward: saleOrder['ward']));
    }
    return saleOrders;
  }

  // Future<SaleOrder?> addSaleOrderAndGetaddedOrder(
  //     {required SaleOrder saleOrder,
  //     required List<SaleOrderLine> orderLines}) async {
  //   int value = await _crudTable.insertData(saleOrderTable, saleOrder.toJson());
  //   int? orderLineValue = await _crudTable
  //       .insertByTransition<int>(saleOrderLineTable, (txn) async {
  //     for (SaleOrderLine saleOrderLine in orderLines) {
  //       return await txn.insert(saleOrderLineTable, saleOrderLine.toJson());
  //     }
  //   });
  //   if (value > 0) {
  //     List<Map<String, dynamic>> saleOrders = await _crudTable
  //         .readData(saleOrderTable, where: 'id = ?', whereArgs: [value]);
  //     if (saleOrders.isNotEmpty) {
  //       return saleOrders.map((e) => SaleOrder.fromJson(e)).first;
  //     }
  //   } else {
  //     return null;
  //   }
  //   return null;
  // }
/*
  Future<SaleOrder?> addSaleOrderAndGetAddedOrder({
    required SaleOrder saleOrder,
    required List<SaleOrderLine> orderLines,
  }) async {
    try {
      return await _crudTable.insertByTransition<SaleOrder?>(saleOrderTable,
          (txn) async {
        // Insert SaleOrder
        int saleOrderId = await txn.insert(saleOrderTable, saleOrder.toJson());

        // Insert each SaleOrderLine
        for (SaleOrderLine saleOrderLine in orderLines) {
          // Map<String, dynamic> lineMap = saleOrderLine.toJson();
          // lineMap['orderId'] = saleOrderId; // Set the foreign key
          // await txn.insert(saleOrderLineTable, lineMap);
          await txn.insert(saleOrderLineTable, saleOrderLine.toJson());
        }

        // Retrieve the inserted SaleOrder
        List<Map<String, dynamic>> saleOrders = await txn.query(
          saleOrderTable,
          where: 'id = ?',
          whereArgs: [saleOrderId],
        );

        if (saleOrders.isNotEmpty) {
          // Retrieve the sale order lines for the inserted sale order
          List<Map<String, dynamic>> orderLineMaps = await txn.query(
            saleOrderLineTable,
            where: 'orderId = ?',
            whereArgs: [saleOrderId],
          );

          List<SaleOrderLine> saleOrderLines =
              orderLineMaps.map((e) => SaleOrderLine.fromJson(e)).toList();

          // Create the SaleOrder object with its SaleOrderLines
          // SaleOrder insertedSaleOrder =
          //     SaleOrder.fromJson(saleOrders.first).copyWith(
          //   saleOrderLines: saleOrderLines,
          // );
          SaleOrder insertedSaleOrder = SaleOrder(
            id: saleOrders.first['id'],
            soNo: saleOrders.first['soNo'],
            orderType: saleOrders.first['orderType'],
            orderDate: saleOrders.first['orderDate'],
            deliveryStatus: saleOrders.first['deliveryStatus'],
            salePersonId: saleOrders.first['salePersonId'],
            salePersonName: saleOrders.first['salePersonName'],
            township: saleOrders.first['township'],
            ward: saleOrders.first['ward'],
            phone: saleOrders.first['phone'],
            customerName: saleOrders.first['customerName'],
            customerId: saleOrders.first['cutomerId'],
            saleOrderLines: saleOrderLines,
          )
              // .copyWith(saleOrderLines: saleOrderLines)
              ;

          return insertedSaleOrder;
        }

        return null;
      });
    } catch (e) {
      debugPrint('Transaction failed:::::::::::::::::::: Error => <<< $e >>>');
      return null;
    }
  }

*/
  // Future<SaleOrder?> addSaleOrder({required SaleOrder saleorder}) async {
  //   int id = await _crudTable.insertData(saleOrderTable, saleorder.toJson());
  //   if(id < 0) {
  //     return null;
  //   }
  //   List<Map<String,dynamic>> saleOrderMap = await _crudTable.readData(saleOrderTable,where : ' id = ?',whereArgs : [id]);
  //   return saleOrderMap.map((so) => so.fromJson()).toList().first;

  // }
}

/*

List<SaleOrder> orders = [];

List<Map<String,dynamic>> saleOrders = db.readData(saleOrderTable);
if(saleOrders.isNotEmpty) {
	for(var so in saleOrders){
		List<OrderLine> orderLines = [];
		List<Map<String,dynamic>> orderLineMap = db.querybyId(saleOrderLineTable, [ so['id'] ]);
		
		if(orderLineMap.isNotEmpty){
			orderLines.add(orderLineMap.map((line) => line.toJson());
			orders.add(SaleOrder(id: so['id'] , saleOrders :orderLines ));
		}else{
			return null;
		}
	}

return orders;

}else{
	return null;
}

*/
