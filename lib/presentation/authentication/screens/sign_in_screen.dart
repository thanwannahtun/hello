// lib/screens/sign_in_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == BlocStatus.authenticated) {
            Navigator.pushReplacementNamed(context, RouteLists.homePage);
          } else if (state.status == BlocStatus.authenticatinFail) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? "Error Signig in!")));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                    style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                      Size(
                        MediaQuery.of(context).size.width / 0.3,
                        50,
                      ),
                    )),
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      context
                          .read<AuthenticationBloc>()
                          .add(SignInEvent(email: email, password: password));
                    },
                    child: const Text('Sign In'),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteLists.singUpPage);
                },
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
