import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: RouteGenerator().generateRoute,
      initialRoute: RouteLists.itemChoose,
    );
  }
}
