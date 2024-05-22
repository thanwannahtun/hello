import 'package:flutter/material.dart';
import 'package:hello/utils/constant_strings.dart';

class SaleOrderCreatePage extends StatelessWidget {
  const SaleOrderCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sale Order Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(ConstantString.paddingM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
