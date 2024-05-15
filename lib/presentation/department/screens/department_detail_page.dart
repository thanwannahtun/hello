import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/department/bloc/department_bloc.dart';
import 'package:hello/presentation/department/model/Department.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/widgets/custom_bottom_sheet.dart';

class DepartmentDetailPage extends StatefulWidget {
  const DepartmentDetailPage({super.key});

  @override
  State<DepartmentDetailPage> createState() => _DepartmentDetailPageState();
}

class _DepartmentDetailPageState extends State<DepartmentDetailPage> {
  late DepartmentBloc _departmentBloc;
  late Department _department;
  List<Department> departmentLists = [];

  @override
  void initState() {
    _departmentBloc = context.read<DepartmentBloc>();
    _nameController = TextEditingController();
    _parentController = TextEditingController();
    _departmentBloc = context.read<DepartmentBloc>()
      ..add(FetchAllDepartmentEvent());
    departmentLists = _departmentBloc.state.departments;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      _department = arguments['department'] as Department;
    }
    super.didChangeDependencies();
  }

  late TextEditingController _nameController;
  late TextEditingController _parentController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? _parentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_department.name ?? "Detail Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ConstantString.paddingM),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // controller: _nameController,
                initialValue: _department.name ?? 'name',
                decoration: const InputDecoration(
                  hintText: 'Department Name',
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  } else {
                    return 'Require this field!';
                  }
                },
                onSaved: (newValue) {
                  _nameController.text = newValue!;
                },
              ),
              TextFormField(
                // controller: _parentController,
                initialValue: _department.parentName ?? 'parent',
                decoration: const InputDecoration(
                  hintText: 'Parent Name',
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  } else {
                    return 'Require this field!';
                  }
                },
                onTap: () async {
                  Department? depart = await CustomBottomSheet<Department>(
                          models: departmentLists)
                      .showBottomSheet(context, title: 'Department');
                  if (depart != null) {
                    _parentId = depart.parentId;
                    _parentController.text = depart.parentName!;
                  }
                },
                onSaved: (newValue) {
                  _parentController.text = newValue!;
                },
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// [test]
              ElevatedButton.icon(
                  onPressed: deleteDepartment,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete')),
              ElevatedButton(
                  style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(100, 50))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      _departmentBloc.add(UpdateDepartmentEvent(
                          department: _department.copyWith(
                        name: _nameController.text,
                        parentName: _parentController.text,
                        parentId: _parentId,
                      )));
                      print(
                          'name : ${_nameController.text} | parent : ${_parentController.text}');
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Update')),
            ],
          ),
        ),
      ],
    );
  }

  deleteDepartment() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure to delete this?'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  return;
                },
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  _departmentBloc
                      .add(DeleteDepartmentEvent(department: _department));
                  Navigator.of(context).pop();
                },
                child: const Text('OK')),
          ],
        );
      },
    );
  }
}
