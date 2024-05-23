import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/models/product.dart';
import 'package:hello/presentation/sale_order/screen/sale_order_create_page.dart';
import 'package:hello/widgets/custom_text_field.dart';

class SaleOrderAddProductsPage extends StatefulWidget {
  const SaleOrderAddProductsPage({super.key});

  @override
  State<SaleOrderAddProductsPage> createState() =>
      _saleOrderAddProductsPageState();
}

class _saleOrderAddProductsPageState extends State<SaleOrderAddProductsPage> {
  final List<Product> _products = [];
  // List<Uom> _uomLists = []; here

  late TextEditingController _productController;
  late TextEditingController _productUomController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productController = TextEditingController();
    _productUomController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    _productUomController.dispose();
    _productController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _productController,
              hintText: 'Product',
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: _productUomController,
              hintText: 'UOM',
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: _quantityController,
              hintText: 'Quantity',
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RouteLists.saleOrderCreatePage);
                      },
                      child: const Text('< Back'))),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouteLists.saleOrderAddProductsPage);
                      },
                      child: const Text('Add More >'))),
            ],
          ),
        ),
      ],
    );
  }
}
