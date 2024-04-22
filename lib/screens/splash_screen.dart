import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/bloc/bloc_state/bloc_status.dart';
import 'package:hello/bloc/inventory/inventory_bloc.dart';
import 'package:hello/bloc/product/product_bloc.dart';
import 'package:hello/models/product.dart';
import 'package:hello/utils/barcode_service.dart';
import 'package:hello/utils/route_lists.dart';
import 'package:hello/widgets/custom_drawer.dart';
import 'package:hello/widgets/custom_widgets.dart';
import 'package:hello/widgets/floating_action_button.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late ProductBloc _productBloc;
  late InventoryBloc _inventoryBloc;

  List<Product> products = [];

  List<Product> scannedProducts = [];

  List<List<dynamic>> csvLists = [];

  String barcodeResult = '';

  @override
  void initState() {
    debugPrint('init method called ');

    super.initState();
    _productBloc = context.read<ProductBloc>()..add(ProductFetchEvent());
    _inventoryBloc = context.read<InventoryBloc>();
    debugPrint('init state : products ( ${_inventoryBloc.state.props} ) ');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build method called : csvLists ( $csvLists ) ');
    debugPrint('build method called : products ( $products ) ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Items'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(
                  RouteLists.emailSenderPage,
                  arguments: {'csv_list': csvLists}),
              child: const Text('Send Email'))
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            switch (state.status) {
              case BlocStatus.fetched:
                products = state.products;
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                break;
              case BlocStatus.fetching:
                SnackBar snackBar =
                    SnackBar(content: Text(state.message)); // scanning
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              case BlocStatus.fetchefailed:
                SnackBar snackBar = SnackBar(content: Text(state.message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              default:
              // SnackBar snackBar = SnackBar(content: Text(state.message));
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state.status == BlocStatus.fetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == BlocStatus.fetchefailed) {
              return Text(state.error);
            } else {
              if (scannedProducts.isEmpty) {
                return const Center(
                  child: Text(
                    'Scan the Products',
                    style: TextStyle(
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                );
              }
              return ScannedProducts(products: scannedProducts);
            }
          },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        text: 'Scan Barcode',
        onPressed: () => scanBarcode(context),
      ),
    );
  }

  Future<void> scanBarcode(BuildContext context) async {
    String result = await BarcodeService.instance.scanBarcode();

    debugPrint(' Scanner result : $result ');
    if (result == '-1') {
      // ignore: use_build_context_synchronously
      CustomWidgets.showSnackBar(context: context, title: result);
    }
    // barcodeResult = result;
    int index = products.indexWhere((element) => element.barcode == result);

    if (index == -1) {
      CustomWidgets.showSnackBar(
          context: context, title: '( index : $index ) ');
      debugPrint(' No Barcode Found ! ( index : $index ) ');
    } else {
      Product product = products[index];
      scannedProducts.add(product);
      _inventoryBloc.add(InventoryUpdateCountEvent(product));

      List<dynamic> rowForCSV = [
        product.productId,
        product.productName,
        product.barcode,
        product.unit
      ];

      // debugPrint(' before csvLists ( $csvLists ) ');

      csvLists.add([...rowForCSV]);
      //  List<List<dynamic>> temp = [...csvLists,rowForCSV];

      debugPrint(' after csvLists ( $csvLists ) ');
    }

    setState(() {});
  }
}

class ScannedProducts extends StatelessWidget {
  const ScannedProducts({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        // if (products.isEmpty) {
        //   return const Center(
        //     child: Text('Add product or Scan the Products'),
        //   );
        // }
        return Card(
          child: ListTile(
            titleTextStyle: textStyle,
            title: Text(products[index].productName ?? ''),
            subtitle: Text(products[index].barcode ?? ''),
            trailing: Text('unit : ${products[index].unit ?? ''}'),
          ),
        );
      },
    );
  }
}
