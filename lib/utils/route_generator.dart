import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/bloc/inventory/inventory_bloc.dart';
import 'package:hello/bloc/product/product_bloc.dart';
import 'package:hello/screens/inventory_page.dart';
import 'package:hello/screens/no_route_page.dart';
import 'package:hello/screens/product_list.dart';
import 'package:hello/screens/product_page.dart';
import 'package:hello/screens/splash_screen.dart';
import 'package:hello/utils/email_sender.dart';
// import 'package:hello/utils/email_sender.dart';
import 'package:hello/utils/route_lists.dart';

class RouteGenerator {
  Route generateRoute(RouteSettings settings) {
    final productBloc = ProductBloc();
    switch (settings.name) {
      case RouteLists.itemChoose:
        return chooseRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ProductBloc>(
                    create: (BuildContext context) => ProductBloc(),
                  ),
                  BlocProvider<InventoryBloc>(
                    create: (BuildContext context) => InventoryBloc(),
                  )
                ], child: const SplashPage()),
            settings: settings);
      case RouteLists.emailSenderPage:
        return chooseRoute(
            builder: (context) => const EmailSender(), settings: settings);
      case RouteLists.inventoryPage:
        return chooseRoute(
            builder: (context) => BlocProvider.value(
                value: InventoryBloc(),
                // create: (context) => ProductBloc(),
                child: const InventoryLists()),
            settings: settings);
      case RouteLists.productPage:
        return chooseRoute(
            builder: (context) => BlocProvider.value(
                  value: productBloc,
                  // create: (context) => ProductBloc(),
                  child: const ProductPage(),
                ),
            settings: settings);

      case RouteLists.productListPage:
        return chooseRoute(
            builder: (context) => BlocProvider.value(
                  value: productBloc,
                  // create: (context) => ProductBloc(),
                  child: const ProductListPage(),
                ),
            // builder: (context) => BlocProvider.value(
            //       value: BlocProvider.of<ProductBloc>(context),
            //       child: const ProductListPage(),
            //     ),
            settings: settings);

      default:
        return chooseRoute(
            builder: (context) => const NoRouteScreen(), settings: settings);
    }
  }

  MaterialPageRoute<T> chooseRoute<T>(
      {required Widget Function(BuildContext context) builder,
      required RouteSettings settings}) {
    return MaterialPageRoute<T>(builder: builder, settings: settings);
  }
}
