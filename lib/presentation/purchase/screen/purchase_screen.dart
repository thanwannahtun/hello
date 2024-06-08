import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/presentation/purchase/bloc/purchase_bloc.dart';
import 'package:hello/presentation/purchase/bloc/purchase_event.dart';
import 'package:hello/presentation/purchase/bloc/purchase_state.dart';

class PurchaseScreen extends StatelessWidget {
  final _productIdController = TextEditingController();
  final _vendorIdController = TextEditingController();
  final _quantityController = TextEditingController();
  final _dateController = TextEditingController();

  PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchases'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _productIdController,
              decoration: const InputDecoration(labelText: 'Product ID'),
            ),
            TextField(
              controller: _vendorIdController,
              decoration: const InputDecoration(labelText: 'Vendor ID'),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Purchase Date'),
            ),
            ElevatedButton(
              onPressed: () async {
                // final productId = int.parse(_productIdController.text);
                // final vendorId = int.parse(_vendorIdController.text);
                // final quantity = int.parse(_quantityController.text);
                // final date = DateTime.parse(_dateController.text);

                // context.read<PurchaseBloc>().add(AddPurchase(
                //       productId: productId,
                //       vendorId: vendorId,
                //       quantity: quantity,
                //       purchaseDate: date,
                //     ));

                Dio dio = Dio();
                var response = await dio.get('http://localhost:3000/products');

                print('response ::::::::::::::: ${response.data}');
              },
              child: const Text('Add Purchase'),
            ),
            Expanded(
              child: BlocBuilder<PurchaseBloc, PurchaseState>(
                builder: (context, state) {
                  if (state is PurchaseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PurchaseLoaded) {
                    return ListView.builder(
                      itemCount: state.purchases.length,
                      itemBuilder: (context, index) {
                        final purchase = state.purchases[index];
                        return ListTile(
                          title: Text('Product ID: ${purchase['product_id']}'),
                          subtitle: Text('Vendor ID: ${purchase['vendor_id']}'),
                        );
                      },
                    );
                  } else if (state is PurchaseError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
