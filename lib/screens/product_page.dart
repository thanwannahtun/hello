import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/bloc/product/product_bloc.dart';
import 'package:hello/models/product.dart';
import 'package:hello/utils/barcode_service.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/utils/share_preference.dart';
import 'package:hello/widgets/custom_widgets.dart';
import 'package:hello/widgets/floating_action_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isEdit = false;
  bool _isInitial = true;
  // bool _isScanned = false;
  bool isGeneraged = true;
  late Product _product;

  late String _productName;
  String? _unit;
  String _barcode = 'Barcode';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ProductBloc _productBloc;

  final double _keyboardHeight = 0;

  // final _barcodeController = TextEditingController();

  String _scannedBarcode = '';

  late int _generatedbarcode = 999000000000;

  late SharePreference prefs;

  // bool isGenerated = false;
  @override
  void initState() {
    super.initState();
    _productBloc = context.read<ProductBloc>()..add(ProductFetchEvent());
    getGeneratedBarcode();
  }

  Future<void> getGeneratedBarcode() async {
    prefs = SharePreference.instance;
    _generatedbarcode = await prefs.getInt('generated_barcode') ?? 999000000000;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    debugPrint('called didchangedependencies');
    if (_isInitial) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        _isEdit = true;
        Map<String, dynamic> arguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        _product = arguments['product'] as Product;
      }
      print(ModalRoute.of<dynamic>(context)!.settings.arguments);
    }
    _isInitial = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuild $widget ');

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Product' : 'New Product'),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: _keyboardHeight),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(ConstantString.paddingM),
            child: form(context),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
          text: _isEdit ? 'Save' : 'Create', onPressed: _saveForm),
    );
  }

  Form form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomWidgets.textFormField(
            hintText: 'Product Name',
            initialValue: _isEdit ? _product.productName : '',
            errorMessage: 'product name is required!',
            onSave: (value) {
              if (value != null && value.isNotEmpty) {
                setState(() {
                  _productName = value;
                });
              }
            },
          ),
          const SizedBox(height: ConstantString.paddingM),
          const SizedBox(height: ConstantString.paddingM),
          CustomWidgets.textFormField(
            hintText: 'Unit',
            initialValue: _isEdit ? _product.unit.toString() : '',
            errorMessage: 'unit is required',
            onSave: (value) {
              if (value != null && value.isNotEmpty) {
                setState(() {
                  _unit = value.toString();
                });
              }
            },
          ),
          const SizedBox(height: ConstantString.paddingM),
          Stack(
            children: [
              CustomWidgets.textFormField(
                hintText: 'Barcode',
                textInputType: TextInputType.number,
                initialValue: _isEdit ? _product.barcode.toString() : '',
                isNeglect: true,
                onSave: (value) {
                  if (isGeneraged) {
                    _barcode = _generatedbarcode.toString();
                    // _barcode = _scannedBarcode;
                  } else {
                    value = _scannedBarcode;
                    _barcode = value;
                  }
                  // _barcode = value ?? _generatedbarcode.toString() || _barcode;
                  // _barcode = _generatedbarcode.toString();
                  // value = _barcode;
                  setState(() {});
                },
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
          //   isGeneraged
          //       ? BarcodeService.instance.showGeneratedBarcode(data: _barcode)
          //       : Container(),
        ],
      ),
    );
  }

  void _saveForm() {
    debugPrint(
        '=> save form, validated = ${_formKey.currentState!.validate()}');
    if (_isEdit) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print('Edit = true , called update Bloc');
        _product.productName = _productName;
        _product.unit = _unit;
        _product.barcode = _barcode;
        _productBloc.add(ProductUpdateEvent(_product));
        // _productBloc.add(ProductUpdateEvent(_product.copyWith(
        //     productName: _productName, barcode: _barcode, unit: _unit)));
        Navigator.pop(context, true);
      }
    } else {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _product = Product(
          productName: _productName,
          unit: _unit,
          barcode: _barcode,
        );

        _productBloc.add(ProductAddEvent(_product));
        // _productBloc.add(ProductUpdateEvent(_product.copyWith(
        // productName: _productName, barcode: _barcode, unit: _unit)));
        print(_product.productName);

        Navigator.pop(context, true);
      }
    }
  }

  void _scanBarcode() async {
    // _isScanned = true;
    print('barcode = $_barcode');
    String barcodeResult = await BarcodeService.instance.scanBarcode();
    // _barcode = barcodeResult;
    _scannedBarcode = barcodeResult;
    print('barcode = $_barcode');
    isGeneraged = false;
    setState(() {});
  }

  _generateBarcode() async {
    if (isGeneraged) {
      _generatedbarcode++;
      _barcode = _generatedbarcode.toString();
      print('after generating $_barcode');
      bool saved = await prefs.setInt('generated_barcode', _generatedbarcode);
      print('barcode saved to prefs = $saved');
      setState(() {});
    } else {
      return;
    }
  }
}
