import 'package:flutter/material.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';

class SaleOrderDetailPage extends StatefulWidget {
  const SaleOrderDetailPage({super.key});

  @override
  State<SaleOrderDetailPage> createState() => _SaleOrderDetailPageState();
}

class _SaleOrderDetailPageState extends State<SaleOrderDetailPage> {
  SaleOrder? saleOrder;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      saleOrder = arguments['saleOrder'] as SaleOrder;
      print('saleOrder :::::::: $saleOrder');
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(saleOrder?.soNo ?? "Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.black12,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Customer'),
                      ),
                      const Divider(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(' ${saleOrder?.customerName} '),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.black12,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Delivery Status'),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(' ${saleOrder?.deliveryStatus} '),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
          const Divider(height: 3),
          Container(
            color: Colors.green,
            child: const Text('Child'),
          )
        ]),
      ),
    );
  }
}
