import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/core/utils/entity.dart';
import 'package:hello/presentation/sale_order/bloc/sale_order_bloc.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/widgets/custom_bottom_sheet.dart';
import 'package:hello/widgets/custom_text_field.dart';
import 'package:hello/widgets/floating_action_button.dart';

class SaleOrderCreatePage extends StatefulWidget {
  const SaleOrderCreatePage({super.key});

  @override
  State<SaleOrderCreatePage> createState() => _SaleOrderCreatePageState();
}

class _SaleOrderCreatePageState extends State<SaleOrderCreatePage> {
  // /* start

  List<Customer> customers = [
    Customer(id: 1, name: 'customer 1'),
    Customer(id: 2, name: 'customer 2'),
    Customer(id: 3, name: 'customer 3'),
    Customer(id: 4, name: 'customer 4'),
    Customer(id: 5, name: 'customer 5'),
    Customer(id: 6, name: 'customer 6'),
    Customer(id: 7, name: 'customer 7'),
    Customer(id: 8, name: 'customer 8'),
    Customer(id: 9, name: 'customer 9'),
    Customer(id: 11, name: 'customer 11'),
    Customer(id: 12, name: 'customer 12'),
    Customer(id: 13, name: 'customer 13'),
    Customer(id: 14, name: 'customer 14'),
    Customer(id: 15, name: 'customer 15'),
  ];

  // */ end
  late TextEditingController _customerNameController;
  late TextEditingController _orderDateController;

  @override
  initState() {
    super.initState();
    _customerNameController = TextEditingController();
    _orderDateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sale Order Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ConstantString.paddingM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _customerNameController,
              hintText: 'Customer Name',
              prefixIcon: const Icon(Icons.person),
              onTap: () async {
                Customer? customer = await CustomBottomSheet(models: customers)
                    .showBottomSheet(context);
                if (customer != null) {
                  _customerNameController.text = customer.name;
                }
              },
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              hintText: "Choose Date",
              prefixIcon: const Icon(Icons.date_range),
              controller: _orderDateController,
              onChanged: (value) {
                _orderDateController.text = value;
              },
            ),
            Container(
              child: BlocBuilder<SaleOrderBloc, SaleOrderState>(
                builder: (context, state) {
                  print('SO state :::::::: $state');
                  // check empty late
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.saleOrders.length,
                    itemBuilder: (context, index) {
                      SaleOrder saleOrder = state.saleOrders[index];
                      return ListTile(
                        title: Text(saleOrder.soNo ?? 'No : '),
                        leading: Text(saleOrder.customerName ?? "Customer : "),
                        trailing: Text(
                            saleOrder.getTotalSaleOrderLineAmount().toString()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
          text: 'Add',
          onPressed: () {
            // go to line add page
            Navigator.pushNamed(context, RouteLists.saleOrderAddProductsPage);
          }),
      persistentFooterButtons: [
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  // show save or discard dialog
                  Navigator.popAndPushNamed(
                      context, RouteLists.saleOrderListPage);
                },
                child: const Text('Back'))),
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  // create new saleOrder
                  //  SaleOrder saleOrder = SaleOrder(customerName:);
                },
                child: const Text('Submit'))),
      ],
    );
  }
}

class Customer extends Entity {
  Customer({required this.id, required this.name})
      : super(entityId: id, entityName: name);
  int id;
  String name;

  @override
  List<Object?> get props => [id, name];
}

///keyboardType:TextInputType.noev
