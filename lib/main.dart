import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/bloc/inventory/inventory_bloc.dart';
import 'package:hello/bloc/product/product_bloc.dart';
import 'package:hello/utils/route_generator.dart';
import 'package:hello/utils/route_lists.dart';
import 'package:hello/utils/theme.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<InventoryBloc>(
          create: (context) => InventoryBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: RouteGenerator().generateRoute,
        initialRoute: RouteLists.itemChoose,
      ),
    );
  }
}
