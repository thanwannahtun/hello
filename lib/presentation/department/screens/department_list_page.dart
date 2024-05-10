import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/department/bloc/department_bloc.dart';
import 'package:hello/presentation/department/screens/department_list_tile.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/widgets/custom_widgets.dart';

class DepartmentListPage extends StatelessWidget {
  const DepartmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(ConstantString.departmentListPage)),
      body: Padding(
        padding: const EdgeInsets.all(ConstantString.paddingM),
        child: BlocBuilder<DepartmentBloc, DepartmentState>(
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (state.departments.isEmpty) {
                  return CustomWidgets.showNoDataWiget(
                      context: context, onPressed: () {});
                }
                return DepartmentListTile(department: state.departments[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
