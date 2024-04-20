import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/bloc/product/product_bloc.dart';
import 'package:hello/screens/no_route_page.dart';
import 'package:hello/screens/product_list.dart';
import 'package:hello/screens/product_page.dart';
import 'package:hello/screens/splash_screen.dart';
import 'package:hello/utils/email_sender.dart';
import 'package:hello/utils/route_lists.dart';

class RouteGenerator {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLists.itemChoose:
        return chooseRoute(
            builder: (context) => const SplashPage(), settings: settings);
      // case RouteLists.emailSenderPage:
      //   return chooseRoute(
      //       builder: (context) => const EmailSender(), settings: settings);
      case RouteLists.productPage:
        return chooseRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ProductBloc(),
                  child: const ProductPage(),
                ),
            settings: settings);

      case RouteLists.productListPage:
        return chooseRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ProductBloc(),
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
