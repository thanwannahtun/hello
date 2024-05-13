import 'package:flutter/material.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/presentation/department/model/Department.dart';

class DepartmentListTile extends StatelessWidget {
  const DepartmentListTile({super.key, required this.department});

  final Department department;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    return InkWell(
      onTap: () {
        _goToDepartmentDetailPage(department: department, context: context);
      },

      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Department :  ${department.name ?? ''}', style: textStyle),
              Text('Parent        :  ${department.parentName ?? ''}',
                  style: textStyle),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  _goToDepartmentDetailPage(
      {required Department department, required BuildContext context}) {
    Navigator.of(context).pushNamed(RouteLists.departmentDetailPage,
        arguments: {'department': department});
  }
}
