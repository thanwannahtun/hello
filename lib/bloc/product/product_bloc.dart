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
    debugPrint('========== fetch Product =========');
    try {
      List<Product> products = await _fetchAllProducts();

      debugPrint('fetched products  => $products');
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
    debugPrint('========== Add Product =========');

    try {
      bool isAdded = await _productRepo.addProduct(event.product.toJson());
      if (!isAdded) {
        print('fail!');
        emit(state.copyWith(
            // products: state.products,
            status: BlocStatus.addfailed,
            error: 'Failed adding products ( ${event.product.productName} )'));
      }
      final temp = state.products;
      temp.add(event.product);

      debugPrint('temp : $temp');

      print('success!');
      // _fetchProduct(ProductFetchEvent(), emit);
      emit(state.copyWith(
          products: temp,
          status: BlocStatus.added,
          message: 'Successfully added ( ${event.product.productName} )'));
    } catch (e) {
      debugPrint('Error Adding Products ( $e )');
      emit(state.copyWith(
          status: BlocStatus.addfailed,
          error: 'Error adding products ( ${event.product.productName} )'));
    }
  }

  FutureOr<void> _updateProduct(
      ProductUpdateEvent event, Emitter<ProductState> emit) async {
    try {
      await _productRepo.updateProduct(product: event.product);
    } catch (e) {
      print(
          'Error Updating Product ( ${event.product.productName} , error : $e )');
    }
  }
}
