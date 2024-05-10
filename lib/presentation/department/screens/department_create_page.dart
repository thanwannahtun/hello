import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/department/bloc/department_bloc.dart';
import 'package:hello/presentation/department/model/Department.dart';
import 'package:hello/utils/constant_strings.dart';

class NewDepartmentPage extends StatefulWidget {
  const NewDepartmentPage({super.key});

  @override
  State<NewDepartmentPage> createState() => _NewDepartmentPageState();
}

class _NewDepartmentPageState extends State<NewDepartmentPage> {
  late DepartmentBloc _departmentBloc;

  @override
  void initState() {
    _departmentBloc = context.read<DepartmentBloc>();
    super.initState();
  }

  final _nameController = TextEditingController(text: '');
  final _parentController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Department')),
      body: Padding(
        padding: const EdgeInsets.all(ConstantString.paddingM),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Department Name',
              ),
            ),
            TextField(
              controller: _parentController,
              decoration: const InputDecoration(
                hintText: 'Parent Name',
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              if (_nameController.text.isEmpty &&
                  _parentController.text.isEmpty) {
                _nameController.text = 'required this field';
                _parentController.text = 'required this field';
                setState(() {});
              } else {
                final department = Department(
                    name: _nameController.text,
                    parentName: _parentController.text);
                _departmentBloc
                    .add(CreateDepartmentEvent(department: department));
                Navigator.pop(context);
              }
            },
            child: const Text('Create'))
      ],
    );
  }
}
