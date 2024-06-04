import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/core/utils/entity.dart';
import 'package:hello/models/product.dart';
import 'package:hello/presentation/product/bloc/product_bloc.dart';
import 'package:hello/presentation/sale_order/bloc/sale_order_bloc.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/presentation/sale_order/model/sale_order_line.dart';
import 'package:hello/widgets/custom_bottom_sheet.dart';
import 'package:hello/widgets/custom_text_field.dart';

class SaleOrderAddProductsPage extends StatefulWidget {
  const SaleOrderAddProductsPage({super.key});

  @override
  State<SaleOrderAddProductsPage> createState() =>
      _saleOrderAddProductsPageState();
}

class _saleOrderAddProductsPageState extends State<SaleOrderAddProductsPage> {
  List<Product> _products = [];

  // /* start

  final List<Uom> _uomLists = [
    Uom(id: 1, name: 'g'),
    Uom(id: 2, name: 'kg'),
    Uom(id: 3, name: 'lb'),
    Uom(id: 4, name: 'wb'),
    Uom(id: 5, name: 'L'),
  ];

  // */ end

  late TextEditingController _productController;
  late TextEditingController _productUomController;
  late TextEditingController _quantityController;

  late ProductBloc _productBloc;

  Product? _product;

  // fields
  double? _unitPrice;

  @override
  void initState() {
    super.initState();
    _productBloc = context.read<ProductBloc>()..add(ProductFetchEvent());
    _products = _productBloc.state.products;
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
              onTap: () async {
                Product? product = await CustomBottomSheet(models: _products)
                    .showBottomSheet(context);
                if (product != null) {
                  _productController.text = product.name ?? 'product';
                  _product = product;
                }
              },
              hintText: 'Product',
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: _productUomController,
              hintText: 'UOM',
              onTap: () async {
                Uom? uom = await CustomBottomSheet(models: _uomLists)
                    .showBottomSheet(context);
                if (uom != null) {
                  _productUomController.text = uom.name;
                }
              },
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
                        Navigator.popAndPushNamed(
                            context, RouteLists.saleOrderCreatePage);
                        // show save or discard dialog
                      },
                      child: const Text('< Back'))),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        // add to bloc
                        SaleOrderLine orderLine = SaleOrderLine(
                            productUnitPrice: _unitPrice,
                            productName: _productController.text,
                            productId: (_product?.id),
                            orderQuantity: int.parse(_quantityController.text),
                            productUom: _productUomController.text);

                        SaleOrderBloc()
                            .add(AddOrderLineEvent(orderLine: orderLine));

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

class Uom extends Entity {
  Uom({required this.id, required this.name})
      : super(entityId: id, entityName: name);
  int id;
  String name;

  @override
  List<Object?> get props => [id, name];
}
