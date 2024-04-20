import 'package:flutter/material.dart';

class NoRouteScreen extends StatelessWidget {
  const NoRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('NO Page you looking for!'),
      ),
    );
  }
}
