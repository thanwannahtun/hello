import 'package:flutter/material.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/config/route/route_lists.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      width: width * 0.8,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        children: [
          const DrawerHeader(
              child: Center(
            child: Icon(Icons.landscape, size: 100, color: Colors.green),
          )),
          const Divider(
            height: ConstantString.paddingM,
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, RouteLists.itemChoose),
            leading: const Icon(Icons.list_rounded),
            title: const Text('Items Choose'),
          ),
          const Divider(
            height: ConstantString.paddingM,
          ),
          ListTile(
            onTap: () =>
                Navigator.pushNamed(context, RouteLists.productListPage),
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('Products'),
          ),
          const Divider(
            height: ConstantString.paddingM,
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, RouteLists.inventoryPage),
            leading: const Icon(Icons.list_rounded),
            title: const Text('Inventory Page'),
          ),
          const Divider(
            height: ConstantString.paddingM,
          ),

          ///[Department]
          ListTile(
            onTap: () =>
                Navigator.pushNamed(context, RouteLists.departmentListPage),
            leading: const Icon(Icons.list_rounded),
            title: const Text('Department List Page'),
          ),
          const Divider(
            height: ConstantString.paddingM,
          ),
        ],
      ),
    );
  }
}
