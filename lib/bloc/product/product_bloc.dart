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
  final ProductRepository _productRepo;

  ProductBloc()
      : _productRepo = ProductRepository(),
        super(const ProductState(
            status: BlocStatus.initial, error: '', message: '', products: [])) {
    on<ProductFetchEvent>(_fetchProduct);
    on<ProductAddEvent>(_addProduct);
    on<ProductUpdateEvent>(_updateProduct);
    on<ProductDeleteEvent>(_deleteProduct);
  }

  Future<List<Product>> _fetchAllProducts() async {
    List<Map<String, dynamic>> productList = await _productRepo.fetchProducts();
    List<Product> products =
        productList.map((e) => Product.fromJson(e)).toList();
    return products.isEmpty ? [] : products;
  }

  FutureOr<void> _fetchProduct(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    // emit(
    //   state.copyWith(status: BlocStatus.fetching, message: 'fetching...'),
    // );
    try {
      List<Product> products = await _fetchAllProducts();

      debugPrint('fetched products  (Bloc) => $products');
      emit(state.copyWith(status: BlocStatus.fetched, products: products));
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatus.fetchefailed,
          error: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _addProduct(
      ProductAddEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: BlocStatus.adding, message: 'adding...'));
    try {
      state.products.add(event.product);

      bool isAdded = await _productRepo.addProduct(event.product.toJson());
      if (!isAdded) {
        emit(state.copyWith(
            status: BlocStatus.addfailed,
            error:
                'Failed to Adding ${event.product.productName} , isAdded = $isAdded'));
      }
      emit(state.copyWith(
          status: BlocStatus.added,
          message: 'successfully added ${event.product.productName}'));

      // state.products.add(event.product);
      // // final products = List<Product>.from(state.products)..add(event.product);

      // List<Product> products = await _fetchAllProducts();
      // // final productsList = await _productRepo.fetchProducts();
      // // final products = productsList.map((e) => Product.fromJson(e)).toList();
      // // print(
      // // '--------------------bloc ($products) ${products.last.productName}');
      // emit(state.copyWith(status: BlocStatus.fetched, products: products));
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.addfailed,
          message: 'Error Adding  ${event.product.productName} : error : $e'));
    }
  }

  // FutureOr<void> _addProduct(
  //     ProductAddEvent event, Emitter<ProductState> emit) async {
  //   emit(state.copyWith(status: BlocStatus.adding, message: 'adding...'));

  //   debugPrint('========== Add Product =========');

  //   try {
  //     bool isAdded = await _productRepo.addProduct(event.product.toJson());
  //     if (!isAdded) {
  //       print('fail!');
  //       emit(state.copyWith(
  //           // products: state.products,
  //           status: BlocStatus.addfailed,
  //           error: 'Failed adding products ( ${event.product.productName} )'));
  //     }
  //     final productCopy = List<Product>.from(state.products)
  //       ..add(event.product);

  //     emit(state.copyWith(
  //         // products: temp,
  //         products: productCopy,
  //         status: BlocStatus.added,
  //         message: 'Successfully added ( ${event.product.productName} )'));
  //   } catch (e) {
  //     debugPrint('Error Adding Products ( $e )');
  //     emit(state.copyWith(
  //         status: BlocStatus.addfailed,
  //         error: 'Error adding products ( ${event.product.productName} )'));
  //   }
  // }

  FutureOr<void> _updateProduct(
      ProductUpdateEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: BlocStatus.updating, message: 'updating...'));
    try {
      bool isUpdated = await _productRepo.updateProduct(product: event.product);
      if (!isUpdated) {
        emit(state.copyWith(
            status: BlocStatus.updatefailed,
            error:
                'Failed to Updating ${event.product.productName} , isUpdated = $isUpdated'));
      } else {
        emit(state.copyWith(
            status: BlocStatus.updated,
            message: 'successfully updated ${event.product.productName}'));
      }
      List<Product> products = await _fetchAllProducts();
      emit(state.copyWith(
        status: BlocStatus.fetched,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.updatefailed,
          message:
              'Error Updating  ${event.product.productName} : error : $e'));
    }
  }

  // FutureOr<void> _updateProduct(
  //     ProductUpdateEvent event, Emitter<ProductState> emit) async {
  //   try {
  //     await _productRepo.updateProduct(product: event.product);
  //   } catch (e) {
  //     print(
  //         'Error Updating Product ( ${event.product.productName} , error : $e )');
  //   }
  // }

  FutureOr<void> _deleteProduct(
      ProductDeleteEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: BlocStatus.deleting, message: 'deleting...'));

    try {
      bool isDeleted = await _productRepo.deleteProduct(product: event.product);

      if (!isDeleted) {
        emit(state.copyWith(
            status: BlocStatus.deletefailed,
            error:
                'Failed to Deleting ${event.product.productName} , deleted = $isDeleted'));
      } else {
        emit(state.copyWith(
            status: BlocStatus.deleted,
            message: 'successfully deleted ${event.product.productName}'));
      }
      List<Product> products = await _fetchAllProducts();
      emit(state.copyWith(status: BlocStatus.fetched, products: products));
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.deletefailed,
          message:
              'Error Deleting  ${event.product.productName} : error : $e'));
    }
  }
}
