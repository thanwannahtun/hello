import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hello/core/bloc/bloc_function.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/presentation/department/model/Department.dart';
import 'package:hello/presentation/department/repo/department_repo.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final DepartmentRepo _departmentRepo;
  DepartmentBloc()
      : _departmentRepo = DepartmentRepo(),
        super(const DepartmentState(
            status: BlocStatus.initial, departments: [])) {
    on<FetchAllDepartmentEvent>(_fetchAllDepartments);
    on<CreateDepartmentEvent>(_createDepartments);
    on<UpdateDepartmentEvent>(_updateDepartments);
  }

  FutureOr<void> _fetchAllDepartments(
      FetchAllDepartmentEvent event, Emitter<DepartmentState> emit) async {
    await BlocFunction.fetchAllData(emit, state, () async {
      final departments = await _departmentRepo.getAllDepartments();
      debugPrint('fetched departments = ${departments.map((e) => e.toJson())}');
      emit(
          state.copyWith(status: BlocStatus.fetched, departments: departments));
    });
  }

  FutureOr<void> _createDepartments(
      CreateDepartmentEvent event, Emitter<DepartmentState> emit) async {
    emit(state.copyWith(status: BlocStatus.adding));
    try {
      Department? department =
          await _departmentRepo.createDepartment(department: event.department);
      if (department != null && department.id != null) {
        debugPrint('added department [ ${department.toJson()} ] ');
        debugPrint('state = ${state.departments}');
        state.departments.add(department);
        debugPrint('state - ${state.departments}');
        emit(state.copyWith(status: BlocStatus.added));
      } else {
        emit(state.copyWith(
            status: BlocStatus.addfailed,
            error: 'Failed Adding new Department'));
      }
    } catch (e) {
      debugPrint('Error -> [ $e ] ');

      emit(state.copyWith(status: BlocStatus.addfailed, error: e.toString()));
    }
  }

  FutureOr<void> _updateDepartments(
      UpdateDepartmentEvent event, Emitter<DepartmentState> emit) async {
    emit(state.copyWith(status: BlocStatus.updating));
    try {
      await _departmentRepo.updateDepartment(department: event.department);
      state.departments[state.departments
              .indexWhere((element) => element.id == event.department.id)] =
          event.department;

      emit(state.copyWith(status: BlocStatus.updated));
    } catch (e) {
      debugPrint('Error -> [ $e ] ');
      emit(
          state.copyWith(status: BlocStatus.updatefailed, error: e.toString()));
    }
  }
}
