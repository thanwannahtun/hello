import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:hello/presentation/inventory/bloc/inventory_state.dart';
import 'package:hello/models/inventory.dart';
import 'package:hello/config/route/route_lists.dart';

class InventoryLists extends StatefulWidget {
  const InventoryLists({super.key});

  @override
  State<InventoryLists> createState() => _InventoryListsState();
}

class _InventoryListsState extends State<InventoryLists> {
  late InventoryBloc _inventoryBloc;

  @override
  void initState() {
    super.initState();
    _inventoryBloc = context.read<InventoryBloc>()..add(InventoryFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Lists'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            print('state : ${state.inventoryLists}');
            if (state.status == BlocStatus.fetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == BlocStatus.fetchefailed) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state.inventoryLists.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('No Product Added'),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, RouteLists.itemChoose),
                        child: Text(
                          'Go to Scan Page',
                          style: Theme.of(context).textTheme.titleLarge,
                        ))
                  ],
                ),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  final inventory = state.inventoryLists[index];
                  return ProductList(inventory: inventory);
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 5,
                    ),
                itemCount: state.inventoryLists.length);
          },
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.inventory});
  final Inventory inventory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" product : ${inventory.productName} "),
          Text(" unit    : ${inventory.unit} "),
          Text(" onHand  : ${inventory.onHand} "),
        ],
      ),
    );
  }
}
