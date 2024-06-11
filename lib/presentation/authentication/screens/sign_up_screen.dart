// lib/screens/sign_up_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == BlocStatus.authenticated) {
            Navigator.pushReplacementNamed(context, RouteLists.homePage);
          } else if (state.status == BlocStatus.authenticatinFail) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? 'Error Signing Up!')));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      labelText: 'User name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state.status == BlocStatus.loading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final username = _usernameController.text;
                        context.read<AuthenticationBloc>().add(SignUpEvent(
                            username: username,
                            email: email,
                            password: password));
                      },
                      child: const Text('Sign Up'),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteLists.singInPage);
                  },
                  child: const Text('Already have an account? Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
