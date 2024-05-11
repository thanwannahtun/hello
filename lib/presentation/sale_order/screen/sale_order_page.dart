import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/sale_order/bloc/sale_order_bloc.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/presentation/sale_order/model/sale_order_line.dart';
import 'package:hello/utils/constant_strings.dart';
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
            const TextField(),
            const Divider(height: ConstantString.paddingM),
            BlocConsumer<SaleOrderBloc, SaleOrderState>(
              builder: (context, state) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.saleOrders.length,
                  itemBuilder: (context, index) {
                    if (state.saleOrders.isEmpty) {
                      return const Text('No Sale Orders created');
                    }
                    return _showSaleOrders(state.saleOrders[index]);
                  },
                );
              },
              listener: (context, state) {},
            )
          ],
        ),
      ),
      floatingActionButton:
          CustomFloatingActionButton(text: "Create", onPressed: () {}),
    );
  }

  Widget _showSaleOrders(SaleOrder saleOrder) {
    // late final controller = SlidableController(vsync);
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    return InkWell(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('', style: textStyle),
              Text('', style: textStyle),
              Text('', style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}