import 'package:flutter/material.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/presentation/department/model/Department.dart';

class DepartmentListTile extends StatelessWidget {
  const DepartmentListTile({super.key, required this.department});

  final Department department;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          _goToDepartmentDetailPage(department: department, context: context),
      title: Text(department.name ?? ''),
      subtitle: Text(department.parentName ?? ''),
    );
  }

  _goToDepartmentDetailPage(
      {required Department department, required BuildContext context}) {
    Navigator.of(context).pushNamed(RouteLists.departmentDetailPage,
        arguments: {'department': department});
  }
}
