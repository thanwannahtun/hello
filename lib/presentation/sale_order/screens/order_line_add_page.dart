// save and new && back

import 'package:flutter/material.dart';
import 'package:hello/utils/constant_strings.dart';

class OrderLineAddPage extends StatefulWidget {
  const OrderLineAddPage({super.key});

  @override
  State<OrderLineAddPage> createState() => _OrderLineAddPageState();
}

class _OrderLineAddPageState extends State<OrderLineAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(ConstantString.paddingM),
        child: Column(),
      ),
      persistentFooterButtons: [
        Expanded(
            child: ElevatedButton(onPressed: () {}, child: const Text('Back'))),
        Expanded(
            child: ElevatedButton(onPressed: () {}, child: const Text('Next')))
      ],
    );
  }
}
