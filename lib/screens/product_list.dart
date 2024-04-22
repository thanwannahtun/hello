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

  List<Product> productList = [];

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
          child: BlocConsumer<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state.status == BlocStatus.fetchefailed) {
                return Center(
                  child: Text(' Erro : ${state.error.toString()}'),
                );
              } else if (state.status == BlocStatus.fetching) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == BlocStatus.initial) {
                return const Center(
                  child: Text('No Data Found'),
                );
              }
              productList = state.products;
              if (productList.isEmpty) {
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
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return showProducts(productList[index]);
                },
              );
            },
            listener: (context, state) {
              // if (state.status == BlocStatus.fetched) {
              //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
              //   productList = state.products;
              // } else if (state.status == BlocStatus.fetchefailed) {
              //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
              //   CustomWidgets.showSnackBar(
              //       context: context, title: state.error);
              // } else
              if (state.status == BlocStatus.fetching) {
                CustomWidgets.showSnackBar(
                    context: context, title: state.message);
              }
              //else {}
            },
          ),
        ),
        floatingActionButton: CustomFloatingActionButton(
          text: 'create product',
          onPressed: () {
            Navigator.of(context)
                .pushNamed(RouteLists.productPage)
                .then((value) {
              if (value == true) {
                print('+++++++++++++++++++++++++++++++++++++');
                _productBloc.add(ProductFetchEvent());
              }
            });
          },
        ));
  }

  Widget showProducts(Product product) {
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    debugPrint('here');
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(RouteLists.productPage, arguments: {'product': product}),
      child: Card(
        child: ListTile(
          title: Text('product : ${product.productName ?? 'product Name'}',
              style: textStyle),
          trailing: Text('unit : ${product.unit ?? 'unit'}', style: textStyle),
          subtitle: Text('barcode : ${product.barcode}', style: textStyle),
        ),
      ),
    );
  }
}
