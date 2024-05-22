import 'package:flutter/material.dart';

class SaleOrderDetailPage extends StatefulWidget {
  const SaleOrderDetailPage({super.key});

  @override
  State<SaleOrderDetailPage> createState() => _SaleOrderDetailPageState();
}

class _SaleOrderDetailPageState extends State<SaleOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Order Detail'), order NO
          ),
      body: const Text('Order Detail'),
    );
  }
}
