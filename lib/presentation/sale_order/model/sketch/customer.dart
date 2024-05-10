import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/main.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';

class Customer {
  Customer({this.id, required this.name, this.email});
  final int? id;
  final String name;
  final String? email;
}

class Order {
  Order(
      {required this.customerId,
      this.productId,
      required this.orderNo,
      required this.orderDate,
      this.id});

  final int? id;
  final int? productId;
  final int customerId;
  final String orderNo;
  final DateTime orderDate;
}

class Product {
  Product(
      {required this.name,
      this.id,
      this.price,
      this.unitId,
      this.orderId,
      this.unitName});

  final int? id;
  final String name;
  final double? price;
  final int? unitId;
  final int? orderId;
  final String? unitName;
}

class Uom {
  Uom({required this.name, this.id});
  final int? id;
  final String name;
}

class OrderWithProducts {
  OrderWithProducts({required this.order, required this.products});

  final Order order;
  final List<Product> products;
}

void main(List<String> args) {
  Product product1 = Product(name: 'apple', price: 30, unitName: 'g');
  Product product2 = Product(name: 'banana', price: 3.0, unitName: 'pound');
  Product product3 = Product(name: 'grape', price: 23, unitName: 'lb');

  Customer customer1 = Customer(id: 1, name: 'Customer1', email: 'email1');
  Customer customer2 = Customer(id: 2, name: 'Customer2', email: 'email2');
  Customer customer3 = Customer(id: 3, name: 'Customer2', email: 'email2');

  Order order1 = Order(
      customerId: customer1.id!,
      orderDate: DateTime.now(),
      orderNo: 'So001'); // id from Database
  Order order2 = Order(
      customerId: customer2.id!,
      orderDate: DateTime.now(),
      orderNo: 'So002'); // id from Database

  final orderWithProducts1 =
      OrderWithProducts(order: order1, products: [product1, product2]);
  final orderWithProducts2 =
      OrderWithProducts(order: order1, products: [product2, product3]);

  print(orderWithProducts2);
  print(orderWithProducts1);
}

dynamic main2(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomerOrderHome(),
    );
  }
}

class CustomerOrderHome extends StatefulWidget {
  const CustomerOrderHome({super.key});

  @override
  State<CustomerOrderHome> createState() => _CustomerOrderHomeState();
}

/*
class _CustomerOrderHomeState extends State<CustomerOrderHome> {
  late CustomerOrderBloc _customerOrderBloc;
  List<Order> orders = [];

  @override
  void initState() {
    _customerOrderBloc = context.read<CustomerOrderBloc>()
      ..add(FetchAllCustomerOrderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
        builder: (context, state) {
          if (state == BlocStatus.fetched) {
            orders = state.orders;
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final Order order = orders[index];
              if (orders.isEmpty) {
                return const Text('No Orders');
              }
              return ListTileWidget(
                  onTap: () {},
                  title: Text(order.orderNo),
                  leading: Text(order.orderDate.toString()),
                  trailing: Text(order.customerId.toString()));
              // return  ListTileWidget(title: Text(order.orderNo), leading: Text(order.orderDate.toString()), trailing: Text(order.customerId));
            },
          );
        },
      ),
    );
  }
}

 */

class _CustomerOrderHomeState extends State<CustomerOrderHome> {
  late CustomerOrderBloc _customerOrderBloc;
  List<OrderWithProducts> orders = [];

  @override
  void initState() {
    _customerOrderBloc = context.read<CustomerOrderBloc>()
      ..add(FetchAllCustomerOrderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
        builder: (context, state) {
          if (state == BlocStatus.fetched) {
            orders = state.orders;
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final OrderWithProducts orderWithProducts = orders[index];
              final Order order = orderWithProducts.order;
              if (orders.isEmpty) {
                return const Text('No Orders');
              }
              return ListTileWidget(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/order_with_details_screen',
                        arguments: <String, OrderWithProducts>{
                          'order_with_products': orderWithProducts
                        });

                    /* pretend this to as order_details screen */
                    OrderWithProducts orderProducts = orderWithProducts;

                    ListView.builder(
                      itemCount: orderProducts.products.length,
                      itemBuilder: (context, index) {
                        final Product product = orderProducts.products[index];

                        return ListTileWidget(
                          title: Text(product.name),
                          leading: Text(product.price.toString()),
                          trailing: Text(product.unitName ?? ''),
                          onTap: () {
                            _customerOrderBloc.add(
                                UpdateCustomerOrderEvent(order: orderProducts));
                          },
                        );
                      },
                    );
                  },
                  title: Text(order.orderNo),
                  leading: Text(order.orderDate.toString()),
                  trailing: Text(order.customerId.toString()));
              // return  ListTileWidget(title: Text(order.orderNo), leading: Text(order.orderDate.toString()), trailing: Text(order.customerId));
            },
          );
        },
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget(
      {super.key,
      required this.title,
      required this.leading,
      required this.trailing,
      this.onTap});

  final Widget title;
  final Widget leading;
  final Widget trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: title,
      leading: leading,
      trailing: trailing,
    );
  }
}

class CustomerOrderBloc extends Bloc<CustomerOrderEvent, CustomerOrderState> {
  CustomerOrderBloc()
      : super(CustomerOrderState(status: BlocStatus.initial, orders: [])) {
    on<FetchAllCustomerOrderEvent>(_fetchCustomerOrders);
    on<UpdateCustomerOrderEvent>(_updateCustomerOrders);
  }

  FutureOr<void> _fetchCustomerOrders(FetchAllCustomerOrderEvent event,
      Emitter<CustomerOrderState> emit) async {
    ///select [Order]

    // int? id; -
    // final int? productId;
    // final int customerId;
    // final String orderNo;
    // final DateTime orderDate;

    String forOrder =
        '''SELECT * FROM Order WHERE customerId = [customerId] and orderDate = [orderDate]''';

    /// [] <- for viscual
    /// [done]

    ///select product by orderId

    // final int? id;
    // final String name;
    // final double? price;
    // final int? unitId;
    // final int? orderId;
    // final String? unitName;
    String forProduct = '''SELECT * FROM Product WHERE orderId = [orderId]''';
    // String query = '''
    //     SELECT
    //     from Order O
    //     JOIN
    //     Customer C
    //     ON
    //     O.customerId = C.id
    //     JOIN /// rewrite here
    //     Product P
    //     ON
    //     O.productId = P.id
    //     WHERE orderId = 1 AND customerId = 1 ;
    // ''';
  }

  FutureOr<void> _updateCustomerOrders(
      UpdateCustomerOrderEvent event, Emitter<CustomerOrderState> emit) async {}
}

// class CustomerOrderState {
//   CustomerOrderState({required this.status, required this.orders});

//   final BlocStatus status;
//   final List<Order> orders;
// }

class CustomerOrderState {
  CustomerOrderState({required this.status, required this.orders, this.error});

  final BlocStatus status;
  final List<OrderWithProducts> orders;
  final String? error;

  CustomerOrderState copyWith(
      {BlocStatus? status, List<OrderWithProducts>? orders, String? error}) {
    return CustomerOrderState(
        status: status ?? this.status,
        orders: orders ?? this.orders,
        error: error ?? this.error);
  }
}

abstract class CustomerOrderEvent {}

class CustomerNewOrderEvent extends CustomerOrderEvent {
  CustomerNewOrderEvent({required this.order});
  final OrderWithProducts order;
}

class FetchAllCustomerOrderEvent extends CustomerOrderEvent {}

class UpdateCustomerOrderEvent extends CustomerOrderEvent {
  UpdateCustomerOrderEvent({required this.order});
  final OrderWithProducts order;
}
