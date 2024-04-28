import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hello/bloc/bloc_state/bloc_status.dart';
import 'package:hello/models/product.dart';
import 'package:hello/repos/product_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  ProductBloc()
      : _productRepository = ProductRepository(),
        super(const ProductState(products: [], status: BlocStatus.initial)) {
    on<ProductAddEvent>(_addProduct);
    on<ProductFetchEvent>(_fetchProducts);
    on<ProductUpdateEvent>(_updateProducts);
    on<ProductDeleteEvent>(_deleteProduct);
  }

  FutureOr<void> _addProduct(
      ProductAddEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: BlocStatus.adding));
    try {
      Product? product = await _productRepository
          .addProductAndGetProduct(event.product.toJson());
      if (product != null && product.productId != null) {
        state.products.add(product);
        emit(state.copyWith(status: BlocStatus.added));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.addfailed, error: e.toString()));
    }
  }

  FutureOr<void> _fetchProducts(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: BlocStatus.fetching));
    try {
      List<Product> products = [];
      List<Map<String, dynamic>> map = await _productRepository.fetchProducts();
      for (var product in map) {
        products.add(Product.fromJson(product));
      }
      emit(state.copyWith(status: BlocStatus.fetched, products: products));
    } catch (e) {
      emit(
          state.copyWith(status: BlocStatus.fetchefailed, error: e.toString()));
    }
  }

  FutureOr<void> _updateProducts(
      ProductUpdateEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: BlocStatus.updating));
    try {
      await _productRepository.updateProduct(product: event.product);
      Product product = state.products.elementAt(event.product.productId!);
      product = event.product;
      emit(state.copyWith(status: BlocStatus.added));
    } catch (e) {
      emit(
          state.copyWith(status: BlocStatus.updatefailed, error: e.toString()));
    }
  }

  FutureOr<void> _deleteProduct(
      ProductDeleteEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: BlocStatus.deleting));

    try {
      bool isDeleted =
          await _productRepository.deleteProduct(product: event.product);

      if (!isDeleted) {
        emit(state.copyWith(
            status: BlocStatus.deletefailed,
            error:
                'Failed to Deleting ${event.product.productName} , deleted = $isDeleted'));
      } else {
        state.products.removeAt(event.product.productId!);

        emit(state.copyWith(status: BlocStatus.deleted));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.deletefailed));
    }
  }
}
