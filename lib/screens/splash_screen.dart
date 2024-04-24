import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/bloc/bloc_state/bloc_status.dart';
import 'package:hello/bloc/inventory/inventory_bloc.dart';
import 'package:hello/bloc/product/product_bloc.dart';
import 'package:hello/models/inventory.dart';
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
    debugPrint('init state : invenoreis ( ${_inventoryBloc.state.props} ) ');
    debugPrint('init state : products ( ${_productBloc.state.props} ) ');
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
        child: BlocBuilder<ProductBloc, ProductState>(
          // listener: (context, state) {
          //   print('listener : ${state.products}');

          //   switch (state.status) {
          //     case BlocStatus.fetched:
          //       products = state.products;
          //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //       break;
          //     case BlocStatus.fetching:
          //       SnackBar snackBar =
          //           SnackBar(content: Text(state.message)); // scanning
          //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //     case BlocStatus.fetchefailed:
          //       SnackBar snackBar = SnackBar(content: Text(state.message));
          //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //     default:
          //     // SnackBar snackBar = SnackBar(content: Text(state.message));
          //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //   }
          // },
          builder: (context, state) {
            print('builder : ${state.products.length}');
            products = state.products;

            if (state.status == BlocStatus.fetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == BlocStatus.fetchefailed) {
              return Text(state.error);
            } else {
              if (scannedProducts.isEmpty) {
                return Center(
                    // child: Text(
                    //   'Scan the Products',
                    //   style: TextStyle(
                    //       fontSize: 90,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.green),
                    // ),
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.qr_code_scanner,
                      size: 200,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () => scanBarcode(context),
                        child: const Text(
                          'Scan Barcode',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ))
                  ],
                ));
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
      CustomWidgets.showSnackBar(context: context, title: "Failed to Scan");
    }
    // barcodeResult = result;
    int index = products.indexWhere((element) => element.barcode == result);

    if (index == -1) {
      CustomWidgets.showSnackBar(context: context, title: 'No product Found!');
      debugPrint(' No Barcode Found ! ( index : $index ) ');
    } else {
      Product product = products[index];
      scannedProducts.add(product);
      // _inventoryBloc.add(InventoryUpdateCountEvent(product));
      print('-------------------inventory splash screen');
      Inventory inventory = Inventory(
          productId: product.productId,
          productName: product.productName,
          unit: product.unit,
          barcode: product.barcode,
          onHand: 1);
      _inventoryBloc.add(InventoryAddOrUpdateEvent(inventory));
      // _inventoryBloc.add(InventoryAddEvent(product));
      print('--------|-----------inventory splash screen');

      List<dynamic> rowForCSV = [
        product.productId,
        product.productName,
        product.barcode,
        product.unit
      ];

      // debugPrint(' before csvLists ( $csvLists ) ');

      // csvLists.add([...rowForCSV]);
      csvLists.add(rowForCSV);
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
