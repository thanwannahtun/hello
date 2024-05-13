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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 3;

    return Scaffold(
      appBar: AppBar(title: const Text('New Department')),
      body: Padding(
        padding: const EdgeInsets.all(ConstantString.paddingL),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
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
              ),
              TextFormField(
                controller: _parentController,
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
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(size, 50))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final department = Department(
                      name: _nameController.text,
                      parentName: _parentController.text);
                  _departmentBloc
                      .add(CreateDepartmentEvent(department: department));
                  Navigator.pop(context);
                }
              },
              child: const Text('Create')),
        )
      ],
    );
  }
}
