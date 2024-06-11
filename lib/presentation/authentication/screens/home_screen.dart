// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:hello/presentation/authentication/cubit/token_check_cubit.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthenticationBloc>().add(SignOutEvent());
                Navigator.pushReplacementNamed(context, RouteLists.singInPage);
              },
            ),
          ],
        ),
        drawer: const CustomDrawer(),
        body: const Center(
          child: Text('Welcome to the Home Screen!'),
        ),
      );
    }, listener: (BuildContext context, AuthenticationState state) {
      if (state.status == BlocStatus.authenticatinFail) {
        Navigator.pushReplacementNamed(context, RouteLists.singInPage);
      }
    });
  }
}
