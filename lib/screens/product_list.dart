import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/bloc/product/product_bloc.dart';
import 'package:hello/models/product.dart';
import 'package:hello/utils/route_lists.dart';
import 'package:hello/widgets/custom_drawer.dart';
import 'package:hello/widgets/floating_action_button.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = context.read<ProductBloc>()..add(ProductFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Lists'),
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          print(
              "State is ::::::::: ${state.status} | products::::::::::: ${state.products.toString()}");
          if (state.products.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_add, size: 100),
                  SizedBox(height: 20),
                  Text('No Product Created')
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return showProducts(state.products[index]);
            },
          );
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        text: 'Create Product',
        onPressed: () {
          Navigator.of(context).pushNamed(RouteLists.productAddPage);
        },
      ),
    );
  }

  Widget showProducts(Product product) {
    // late final controller = SlidableController(vsync);
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteLists.productPage,
            arguments: {'product': product});
      },
      child: Dismissible(
        key: Key(product.productId.toString()),
        onDismissed: (direction) {
          _productBloc.add(ProductDeleteEvent(product.productId!));
          if (!context.mounted) return;
          setState(() {});
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('product :  ${product.productName ?? 'product Name'}',
                    style: textStyle),
                Text('unit        :  ${product.unit ?? 'unit'}',
                    style: textStyle),
                Text('barcode :  ${product.barcode}', style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
