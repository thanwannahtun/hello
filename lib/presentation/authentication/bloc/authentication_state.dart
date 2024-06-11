part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final BlocStatus status;
  final String? error;

  const AuthenticationState({required this.status, this.error});

  @override
  List<Object> get props => [];
  AuthenticationState copyWith({BlocStatus? status, String? error}) {
    return AuthenticationState(
        status: status ?? this.status, error: error ?? this.error);
  }
}
