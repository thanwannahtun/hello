import 'package:hello/data/database/constant_tables.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/presentation/department/model/Department.dart';

class DepartmentRepo {
  final CRUDTable _crudTable;
  final String _departmentTable =
      'category_table'; //ConstantTables.categoryTable;
  DepartmentRepo() : _crudTable = CRUDTable.instance;

  Future<List<Department>> getAllDepartments() async {
    final departmentMap = await _crudTable.readData(_departmentTable);
    if (departmentMap.isNotEmpty) {
      return List<Department>.generate(departmentMap.length,
          (index) => Department.fromJson(departmentMap[index]));
    } else {
      return [];
    }
  }

  Future<Department?> createDepartment({required Department department}) async {
    int value =
        await _crudTable.insertData(_departmentTable, department.toJson());
    if (value > 0) {
      final map = await _crudTable
          .readData(_departmentTable, where: ' id = ?', whereArgs: [value]);
      if (map.isNotEmpty) {
        return map.map((e) => Department.fromJson(e)).toList().first;
      } else {
        return null;
      }
    }
    return null;
  }
}
