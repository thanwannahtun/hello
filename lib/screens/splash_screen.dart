import 'package:flutter/material.dart';
import 'package:hello/utils/barcode_service.dart';
import 'package:hello/utils/route_lists.dart';
import 'package:hello/widgets/custom_drawer.dart';
import 'package:hello/widgets/floating_action_button.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String barcodeResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Items'),
        actions: [
          ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteLists.emailSenderPage),
              child: const Text('Send Email'))
        ],
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: CustomFloatingActionButton(
        text: 'Scan Barcode',
        onPressed: () => scanBarcode(),
      ),
    );
  }

  scanBarcode() async {
    String result = await BarcodeService.instance.scanBarcode();
    if (result == '-1') {
      print(
          ' ==============================-barcodeResult $result-===============================');
    }
    barcodeResult = result;
    print(
        '--------------------------------------------------------barcodeResult----------------------------------------');
    print(barcodeResult);
    setState(() {});
  }
}
