import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/presentation/department/bloc/department_bloc.dart';
import 'package:hello/presentation/department/model/Department.dart';
import 'package:hello/presentation/department/screens/department_list_tile.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/widgets/custom_widgets.dart';
import 'package:hello/widgets/floating_action_button.dart';

class DepartmentListPage extends StatefulWidget {
  const DepartmentListPage({super.key});

  @override
  State<DepartmentListPage> createState() => _DepartmentListPageState();
}

class _DepartmentListPageState extends State<DepartmentListPage> {
  @override
  void initState() {
    context.read<DepartmentBloc>().add(FetchAllDepartmentEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(ConstantString.departmentListPage)),
      // body: Padding(
      // padding: const EdgeInsets.all(ConstantString.paddingM),
      body: BlocBuilder<DepartmentBloc, DepartmentState>(
        builder: (context, state) {
          debugPrint(
              'XXXXXXXXXXXXXXXXX : state :[ ${state.status} | length ${state.departments.length}]');
          if (state.departments.isEmpty) {
            return CustomWidgets.showNoDataWiget(
                context: context, onPressed: () {});
          }
          return ListView.builder(
            itemCount: state.departments.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return DepartmentListTile(department: state.departments[index]);
            },
          );
        },
      ),
      // ),
      floatingActionButton: CustomFloatingActionButton(
        text: 'New',
        onPressed: () {
          Navigator.of(context).pushNamed(RouteLists.departmentCreatePage);
        },
      ),
    );
  }
}
