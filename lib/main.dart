import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:hello/presentation/authentication/cubit/token_check_cubit.dart';
import 'package:hello/presentation/department/bloc/department_bloc.dart';
import 'package:hello/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:hello/presentation/product/bloc/product_bloc.dart';
import 'package:hello/config/route/route_generator.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/config/theme/theme.dart';
import 'package:hello/presentation/sale_order/bloc/sale_order_bloc.dart';

void main(List<String> args) {
  //WidgetBinding.ensureInitialize();
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

        /// [Department]
        BlocProvider<DepartmentBloc>(
          create: (context) => DepartmentBloc(),
        ),
        BlocProvider<SaleOrderBloc>(
          create: (context) => SaleOrderBloc(),
        ),

        BlocProvider<TokenCheckCubit>(
          create: (context) => TokenCheckCubit(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: RouteGenerator().generateRoute,
        initialRoute: RouteLists.homePage,
      ),
    );
  }
}
