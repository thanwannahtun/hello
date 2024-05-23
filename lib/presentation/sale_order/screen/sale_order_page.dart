import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/presentation/sale_order/bloc/sale_order_bloc.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/presentation/sale_order/model/sale_order_line.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/widgets/custom_search_text_field.dart';
import 'package:hello/widgets/custom_widgets.dart';
import 'package:hello/widgets/floating_action_button.dart';

class SaleOrderPage extends StatefulWidget {
  const SaleOrderPage({super.key});

  @override
  State<SaleOrderPage> createState() => _SaleOrderPageState();
}

class _SaleOrderPageState extends State<SaleOrderPage> {
  late SaleOrderBloc _saleOrderBloc;

  List<SaleOrder> saleOrders = [];
  List<SaleOrderLine> saleOrderLines = [];

  @override
  void initState() {
    _saleOrderBloc = context.read<SaleOrderBloc>()..add(SaleOrderGetAllEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sale Order Page')),
      body: Container(
        padding: const EdgeInsets.all(ConstantString.paddingM),
        child: Column(
          children: [
            const SizedBox(height: ConstantString.paddingM),
            const Divider(height: ConstantString.paddingM),
            BlocConsumer<SaleOrderBloc, SaleOrderState>(
              builder: (context, state) {
                if (state.status == BlocStatus.fetching) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.saleOrders.isEmpty) {
                  return CustomWidgets.showNoDataWiget(
                    context: context,
                    onPressed: () {},
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.saleOrders.length,
                  itemBuilder: (context, index) {
                    return _showSaleOrders(state.saleOrders[index]);
                  },
                );
              },
              listener: (context, state) {
                if (state.status == BlocStatus.fetching) {}
              },
            )
          ],
        ),
      ),
      // floatingActionButton: CustomFloatingActionButton(
      //     text: "Create", onPressed: () => _saleOrderCreatePage()),
      persistentFooterButtons: [
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
                minimumSize: MaterialStatePropertyAll(
                    Size(MediaQuery.of(context).size.width / 3, 50))),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteLists.saleOrderCreatePage);
            },
            child: const Text('New Sale Order'),
          ),
        ),
      ],
    );
  }

  _saleOrderCreatePage() {
    Navigator.of(context).pushNamed(RouteLists.saleOrderCreatePage);
  }

  Widget _showSaleOrders(SaleOrder saleOrder) {
    // late final controller = SlidableController(vsync);
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteLists.saleOrderDetailPage,
            arguments: {'saleOrder': saleOrder});
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(saleOrder.soNo ?? "", style: textStyle),
                      Text(saleOrder.customerName ?? "", style: textStyle),
                      Text(saleOrder.orderDate ?? "", style: textStyle),
                    ],
                  )),
              Expanded(
                  child: Column(
                children: [
                  Text(saleOrder.deliveryStatus ?? "", style: textStyle),
                  Text(saleOrder.getTotalSaleOrderLineAmount().toString(),
                      style: textStyle),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
