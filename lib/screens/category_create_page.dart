import 'package:flutter/material.dart';
import 'package:hello/utils/constant_strings.dart';

class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({super.key});

  @override
  State<CategoryCreatePage> createState() => _CategoryCreatePageState();
}

class _CategoryCreatePageState extends State<CategoryCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Category'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(ConstantString.paddingM),
        child: Form(
            child: Column(
          children: [],
        )),
      ),
    );
  }
}
