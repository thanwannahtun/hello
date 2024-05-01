import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/presentation/product/bloc/product_bloc.dart';
import 'package:hello/models/product.dart';
import 'package:hello/utils/barcode_service.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/utils/share_preference.dart';
import 'package:hello/widgets/custom_widgets.dart';
import 'package:hello/widgets/floating_action_button.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  bool isGenerated = true;

  late Product _product;

  String? _productName;

  String? _unit;

  String _barcode = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ProductBloc _productBloc;
  String _scannedBarcode = '';

  int _generatedBarcode = 999000000000;

  late SharePreference prefs;

  // bool isGenerated = false;
  @override
  void initState() {
    super.initState();
    _productBloc = context.read<ProductBloc>();
    getGeneratedBarcode();
  }

  Future<void> getGeneratedBarcode() async {
    prefs = SharePreference.instance;
    _generatedBarcode = await prefs.getInt('generated_barcode') ?? 999000000000;
    setState(() {});
  }

  final _barcodeController = TextEditingController();
  final _unitController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: form(context),
      ),
      floatingActionButton: CustomFloatingActionButton(
        text: 'Add',
        onPressed: _saveForm,
      ),
    );
  }

  Form form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            onSaved: (newValue) {
              _productName = newValue!;
            },
            validator: (newValue) {
              if (newValue != null && newValue.isNotEmpty) {
                return null;
              } else {
                return 'Require this field!';
              }
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Product Name'),
          ),
          const SizedBox(
            height: 10,
          ),

          TextFormField(
            controller: _unitController,
            onSaved: (newValue) {
              _unit = newValue!;
            },
            validator: (newValue) {
              if (newValue != null && newValue.isNotEmpty) {
                return null;
              } else {
                return 'Require this field!';
              }
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Product Unit'),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              TextFormField(
                controller: _barcodeController,
                onSaved: (newValue) {
                  _barcode = newValue!;
                },
                validator: (newValue) {
                  if (newValue != null && newValue.isNotEmpty) {
                    return null;
                  } else {
                    return 'Require this field!';
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Barcode'),
              ),
              Positioned(
                right: 12,
                top: 10,
                child: CircleAvatar(
                  child: IconButton(
                      onPressed: _scanBarcode,
                      icon: const Icon(Icons.qr_code_scanner_rounded)),
                ),
              ),
            ],
          ),
          const SizedBox(height: ConstantString.paddingM),
          ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: _generateBarcode,
              child: const Text(
                'generate',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          const SizedBox(
            width: 5,
          ),
          // if (_isEdit)
          //   isGenerated
          //       ? BarcodeService.instance.showGeneratedBarcode(data: _barcode)
          //       : Container(),
        ],
      ),
    );
  }

  void _scanBarcode() async {
    debugPrint('barcode = $_barcode');
    String barcodeResult = await BarcodeService.instance.scanBarcode();
    _scannedBarcode = barcodeResult;
    isGenerated = false;
    _barcodeController.text = _scannedBarcode;
    setState(() {});
  }

  _generateBarcode() async {
    if (isGenerated) {
      _generatedBarcode++;
      _barcode = _generatedBarcode.toString();
      // bool saved = await prefs.setInt('generated_barcode', _generatedBarcode);
      await prefs.setInt('generated_barcode', _generatedBarcode);

      _barcodeController.text = _generatedBarcode.toString();
      setState(() {});
    } else {
      return;
    }
  }

  void _saveForm() {
    debugPrint(
        '=> save form, validated = ${_formKey.currentState!.validate()}');

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _product = Product(
        productName: _productName,
        unit: _unit,
        barcode: _barcode,
      );

      _productBloc.add(ProductAddEvent(_product));
      Navigator.pop(context);
    }
  }
}
