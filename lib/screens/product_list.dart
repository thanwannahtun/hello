import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/bloc/bloc_state/bloc_status.dart';
import 'package:hello/bloc/product/product_bloc.dart';
import 'package:hello/models/product.dart';
import 'package:hello/utils/route_lists.dart';
import 'package:hello/widgets/custom_drawer.dart';
import 'package:hello/widgets/custom_widgets.dart';
import 'package:hello/widgets/floating_action_button.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductBloc _productBloc;

  // List<Product> productList = [];

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
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              debugPrint(
                  '============== state : ${state.status} products : ${state.products}');

              if (state.status == BlocStatus.fetchefailed) {
                return Center(
                  child: Text(' Erro : ${state.error.toString()}'),
                );
              }
              if (state.status == BlocStatus.fetching) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == BlocStatus.initial) {
                return const Center(
                  child: Text('No Data Found'),
                );
              }

              // if (state.status == BlocStatus.fetched) {
              // productList = state.products;
              if (state.products.isEmpty) {
                return Center(
                  child: Icon(
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                    Icons.space_dashboard_rounded,
                    size: 50,
                  ),
                );
              }
              // print('----------fetched state => ${state.status}');
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return showProducts(state.products[index]);
                },
              );
            },
          ),
        ),
        floatingActionButton: CustomFloatingActionButton(
            text: 'create product',
            onPressed: () {
              Navigator.pushNamed(context, RouteLists.productPage)
                  .then((value) {
                if (value == true && value != null) {
                  _productBloc.add(ProductFetchEvent());
                }
              });

              // Navigator.of(context).pushNamed(RouteLists.productPage);
            }));
  }

  Widget showProducts(Product product) {
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    return InkWell(
        onTap: () => Navigator.pushNamed(context, RouteLists.productPage,
            arguments: {'product': product}),
        // onTap: () => Navigator.of(context)
        //     .pushNamed(RouteLists.productPage, arguments: {'product': product}),

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
        ));
  }
}
