import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';

class BlocFunction {
  static dynamic fetchAllData<T>(
      Emitter<T> emit, dynamic state, Future<void> Function() callBack) async {
    emit(state.copyWith());
    try {
      await callBack();
    } catch (e) {
      debugPrint('Exception xxxxxxxxxxxxxxxxxxx [ $e ]');
      emit(
          state.copyWith(status: BlocStatus.fetchefailed, error: e.toString()));
    }
  }
}
