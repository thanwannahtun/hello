import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/models/category.dart';
import 'package:hello/presentation/category/repo/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo _categoryRepo;
  CategoryBloc()
      : _categoryRepo = CategoryRepo(),
        super(const CategoryState(categories: [], status: BlocStatus.initial)) {
    on<CategoryAddEvent>(_addCategory);
    on<CategoryEditEvent>(_editCategory);
    on<CategoryDeleteEvent>(_deleteCategory);
  }

  FutureOr<void> _deleteCategory(
      CategoryDeleteEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: BlocStatus.deleting));
    try {
      bool deleted =
          await _categoryRepo.deleteCategory(categoryId: event.categoryId);
      if (deleted) {
        state.categories.removeAt(event.categoryId);
        emit(state.copyWith(status: BlocStatus.deleted));
      } else {
        emit(state.copyWith(
            status: BlocStatus.deletefailed,
            error: 'Failed Deleting Category :: ${event.categoryId}'));
      }
    } catch (e) {
      debugPrint('Error At _deleteCategory $e');
      emit(
          state.copyWith(status: BlocStatus.deletefailed, error: e.toString()));
    }
  }

  FutureOr<void> _addCategory(
      CategoryAddEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: BlocStatus.adding));
    try {
      Category? category = await _categoryRepo.addCategoryAndReturnCategory(
          values: event.category.toJson());
      if (category != null && category.categoryId != null) {
        state.categories.add(category);
        emit(state.copyWith(status: BlocStatus.added));
      } else {
        emit(state.copyWith(
            status: BlocStatus.addfailed,
            error: 'Failed adding category ${event.category.categoryName}'));
      }
    } catch (e) {
      debugPrint('Error At _addCategory $e');
      emit(state.copyWith(status: BlocStatus.addfailed, error: e.toString()));
    }
  }

  FutureOr<void> _editCategory(
      CategoryEditEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: BlocStatus.updating));
    try {
      bool updated =
          await _categoryRepo.updateCategory(values: event.category.toJson());
      if (updated) {
        Category category =
            state.categories.elementAt(event.category.categoryId!);
        category = event.category;
        emit(state.copyWith(status: BlocStatus.updated));
      } else {
        emit(state.copyWith(
            status: BlocStatus.updatefailed,
            error: 'Failed Updating Category ${event.category.categoryName}'));
      }
    } catch (e) {
      debugPrint('Error At _editCategory $e');
      emit(
          state.copyWith(status: BlocStatus.updatefailed, error: e.toString()));
    }
  }
}
