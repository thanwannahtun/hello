import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/department/bloc/department_bloc.dart';
import 'package:hello/presentation/department/model/Department.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/widgets/custom_widgets.dart';

class DepartmentDetailPage extends StatefulWidget {
  const DepartmentDetailPage({super.key});

  @override
  State<DepartmentDetailPage> createState() => _DepartmentDetailPageState();
}

class _DepartmentDetailPageState extends State<DepartmentDetailPage> {
  late DepartmentBloc _departmentBloc;
  late Department _department;

  @override
  void initState() {
    _departmentBloc = context.read<DepartmentBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      Map<String, Department> arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, Department>;

      _department = arguments['department']!;
    }
    super.didChangeDependencies();
  }

  final _nameController = TextEditingController();
  final _parentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_department.name ?? "Detail Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ConstantString.paddingM),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              initialValue: _department.name ?? 'name',
              decoration: const InputDecoration(
                hintText: 'Department Name',
              ),
            ),
            TextFormField(
              controller: _parentController,
              initialValue: _department.parentName ?? 'parent',
              decoration: const InputDecoration(
                hintText: 'Parent Name',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
