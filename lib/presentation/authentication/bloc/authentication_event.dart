part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;

  const SignUpEvent(
      {required this.username, required this.email, required this.password});
}

class SignOutEvent extends AuthenticationEvent {}
