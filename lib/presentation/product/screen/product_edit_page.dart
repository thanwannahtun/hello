// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hello/bloc/product/product_bloc.dart';
// import 'package:hello/models/product.dart';
// import 'package:hello/utils/barcode_service.dart';
// import 'package:hello/utils/constant_strings.dart';
// import 'package:hello/widgets/floating_action_button.dart';

// class ProductEditPage extends StatefulWidget {
//   const ProductEditPage({super.key});

//   @override
//   State<ProductEditPage> createState() => _ProductEditPageState();
// }

// class _ProductEditPageState extends State<ProductEditPage> {
//   late ProductBloc _productBloc;

//   late Product _product;

//   bool isGenerated = true;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _productBloc = context.read<ProductBloc>();
//   }

//   @override
//   void didChangeDependencies() {
//     if (ModalRoute.of(context)?.settings.arguments != null) {
//       Map<String, dynamic> arguments =
//           ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

//       _product = arguments['product'] as Product;
//     }
//     super.didChangeDependencies();
//   }

//   final _barcodeController = TextEditingController();
//   final _unitController = TextEditingController();
//   final _nameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Product'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: form(context),
//       ),
//       floatingActionButton: CustomFloatingActionButton(
//         text: 'Add',
//         onPressed: _saveForm,
//       ),
//     );
//   }

//   Form form(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             controller: _nameController,
//             onSaved: (newValue) {
//               _product.productName = newValue!;
//             },
//             validator: (newValue) {
//               if (newValue != null && newValue.isNotEmpty) {
//                 return null;
//               } else {
//                 return 'Require this field!';
//               }
//             },
//             decoration: const InputDecoration(
//                 border: OutlineInputBorder(), hintText: 'Product Name'),
//           ),
//           const SizedBox(
//             height: 10,
//           ),

//           TextFormField(
//             controller: _unitController,
//             onSaved: (newValue) {
//               _product.unit = newValue!;
//             },
//             validator: (newValue) {
//               if (newValue != null && newValue.isNotEmpty) {
//                 return null;
//               } else {
//                 return 'Require this field!';
//               }
//             },
//             decoration: const InputDecoration(
//                 border: OutlineInputBorder(), hintText: 'Product Unit'),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Stack(
//             children: [
//               TextFormField(
//                 controller: _barcodeController,
//                 onSaved: (newValue) {
//                   _product.barcode = newValue!;
//                 },
//                 validator: (newValue) {
//                   if (newValue != null && newValue.isNotEmpty) {
//                     return null;
//                   } else {
//                     return 'Require this field!';
//                   }
//                 },
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(), hintText: 'Barcode'),
//               ),
//               Positioned(
//                 right: 12,
//                 top: 10,
//                 child: CircleAvatar(
//                   child: IconButton(
//                       onPressed: _scanBarcode,
//                       icon: const Icon(Icons.qr_code_scanner_rounded)),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: ConstantString.paddingM),
//           ElevatedButton(
//               style: Theme.of(context).elevatedButtonTheme.style,
//               onPressed: _generateBarcode,
//               child: const Text(
//                 'generate',
//                 style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20),
//               )),
//           const SizedBox(
//             width: 5,
//           ),
//           // if (_isEdit)
//           //   isGenerated
//           //       ? BarcodeService.instance.showGeneratedBarcode(data: _barcode)
//           //       : Container(),
//         ],
//       ),
//     );
//   }

//   void _scanBarcode() async {
//     String barcodeResult = await BarcodeService.instance.scanBarcode();
//     _generatedbarcode = barcodeResult;
//     isGenerated = false;
//     _barcodeController.text = barcodeResult;
//     setState(() {});
//   }

//   _generateBarcode() async {
//     if (isGenerated) {
//       _generatedBarcode++;
//       _barcode = _generatedBarcode.toString();
//       // bool saved = await prefs.setInt('generated_barcode', _generatedBarcode);
//       await prefs.setInt('generated_barcode', _generatedBarcode);

//       _barcodeController.text = _generatedBarcode.toString();
//       setState(() {});
//     } else {
//       return;
//     }
//   }
// }
