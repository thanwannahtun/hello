import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/widgets.dart';

class BarcodeService {
  static final BarcodeService instance = BarcodeService._private();
  BarcodeService._private();

  Widget showGeneratedBarcode({required String data, double? width}) {
    return BarcodeWidget(
      data: data,
      barcode: Barcode.code128(),
      errorBuilder: (ctx, error) => Center(
        child: Text(error),
      ),
      margin: const EdgeInsets.only(top: 10),
      width: width ?? 200,
    );
  }

  Future<String> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      barcodeScanRes = 'Failed to scan Barcode!';
    }

    return barcodeScanRes;
  }
}
