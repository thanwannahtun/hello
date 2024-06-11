import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hello/presentation/authentication/repo/authentication.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late final AuthenticationRepo _authenticationRepo;

  AuthenticationBloc()
      : _authenticationRepo = AuthenticationRepo(),
        super(const AuthenticationState(status: BlocStatus.initial)) {
    on<SignInEvent>(_signIn);
    on<SignUpEvent>(_signUp);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _signIn(
      SignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      await _authenticationRepo.signIn(
          email: event.email, password: event.password);
      emit(state.copyWith(status: BlocStatus.authenticated));
    } catch (e) {
      debugPrint('Error ( Auth ) :::::::: $e');
      emit(state.copyWith(
          status: BlocStatus.authenticatinFail, error: e.toString()));
    }
  }

  FutureOr<void> _signUp(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      await _authenticationRepo.singUp(
          username: event.username,
          email: event.email,
          password: event.password);
      emit(state.copyWith(status: BlocStatus.authenticated));
    } catch (e) {
      debugPrint('Error ( Auth ) :::::::: $e');
      emit(state.copyWith(
          status: BlocStatus.authenticatinFail, error: e.toString()));
    }
  }

  FutureOr<void> _signOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      await _authenticationRepo.signOut();
      emit(state.copyWith(status: BlocStatus.initial));
    } catch (e) {
      debugPrint('Error ( Auth ) :::::::: $e');
      emit(state.copyWith(
          status: BlocStatus.authenticatinFail, error: e.toString()));
    }
  }
}
