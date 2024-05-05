import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/utils/constant_culumns.dart';

class SaleOrderRepo {
  final CRUDTable _crudTable;

  SaleOrderRepo() : _crudTable = CRUDTable.instance;

  final saleOrderTable = ConstantTables.saleOrderTable;
  Future<List<SaleOrder>> getAllSaleOrders() async {
    List<SaleOrder> saleOrders = [];
    List<Map<String, dynamic>> saleOrdersMap =
        await _crudTable.readData(saleOrderTable);
    for (var order in saleOrdersMap) {
      saleOrders.add(SaleOrder.fromJson(order));
    }
    return saleOrders;
  }

  Future<SaleOrder?> addSaleOrderAndGetaddedOrder(
      {required SaleOrder saleOrder}) async {
      int value =
          await _crudTable.insertData(saleOrderTable, saleOrder.toJson());
      if (value > 0) {
        List<Map<String, dynamic>> saleOrders = await _crudTable
            .readData(saleOrderTable, where: 'id = ?', whereArgs: [value]);
            if(saleOrder.isNotEmpty){
            return saleOrders.map((e)=> SaleOrder.fromJson(e)).first;
            } 
      } else {
        return null;
      }
  }
  
}
