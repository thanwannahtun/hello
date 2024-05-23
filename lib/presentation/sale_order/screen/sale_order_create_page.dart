import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/models/product.dart';
import 'package:hello/presentation/product/bloc/product_bloc.dart';
import 'package:hello/presentation/sale_order/bloc/sale_order_bloc.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/widgets/custom_text_field.dart';

class SaleOrderCreatePage extends StatefulWidget {
  const SaleOrderCreatePage({super.key});

  @override
  State<SaleOrderCreatePage> createState() => _SaleOrderCreatePageState();
}

class _SaleOrderCreatePageState extends State<SaleOrderCreatePage> {
  final List<DateTime?> _dates = [];

  DateTime? startDate = DateTime.now();

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  // late SaleOrderBloc _saleOrderBloc;
  // customer Bloc for selecting customer
  // product Bloc for selecting products
  late ProductBloc _productBloc;
  List<Product> products = [];

  late TextEditingController _customerController;
  late TextEditingController _dateController;
  final DateTime _orderDate = DateTime.now();
  @override
  void initState() {
    _customerController = TextEditingController(text: '');
    _dateController = TextEditingController(text: '');
    // _saleOrderBloc = context.read<SaleOrderBloc>();
    _productBloc = context.read<ProductBloc>()..add(ProductFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sale Order Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ConstantString.paddingM),
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return CustomTextField(
                    controller: _dateController,
                    hintText: 'Order Date',
                    prefixIcon: const Icon(Icons.date_range),
                    onChanged: (value) {},
                    // onTap: () async {
                    //   List<DateTime?>? results =
                    //       await showCalendarDatePicker2Dialog(
                    //     context: context,
                    //     config: CalendarDatePicker2WithActionButtonsConfig(),
                    //     dialogSize: const Size(325, 400),
                    //     value: _dates,
                    //     borderRadius: BorderRadius.circular(15),
                    //   );
                    //   debugPrint("date time xxxxxxxxxxxxxxxxxxxxx : $results");
                    // },
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _customerController,
                hintText: 'Customer Name',
                prefixIcon: const Icon(Icons.person),
              ), //customer Name
              // Date Picker
              const SizedBox(
                height: 5,
              ),

              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteLists.saleOrderAddProductsPage);
                  },
                  child: const Text('Add Products')), // Product List Add
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Text('hello $index');
                },
              ))
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                if (_fromKey.currentState!.validate()) {
                  _fromKey.currentState!.save();
                  SaleOrder saleOrder = const SaleOrder();
                }
                Navigator.pushNamed(context, RouteLists.saleOrderListPage);
              },
              child: const Text('Comfirm Orders')),
        )
      ],
    );
  }
}
