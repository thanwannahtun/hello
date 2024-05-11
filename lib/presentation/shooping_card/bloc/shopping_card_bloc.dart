import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/models/product.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/presentation/shooping_card/models/product_line.dart';
import 'package:hello/presentation/shooping_card/models/shopping_card.dart';
import 'package:hello/presentation/shooping_card/repo/shopping_card_repo.dart';

part 'shopping_card_event.dart';
part 'shopping_card_state.dart';

class ShoppingCardBloc extends Bloc<ShoppingCardEvent, ShoppingCardState> {
  ShoppingCardBloc()
      : _shoppingCardRepo = ShoppingCardRepo(),
        super(ShoppingCardState(
            status: BlocStatus.initial, productLines: const [])) {
    on<ShoppingCardAddProductEvent>(_addToCard);
    on<ShoppingCardRemoveProductEvent>(_removeFromCard);
    on<ShoppingCardUpdateQuantityEvent>(_updateQuantiry);
  }

  final ShoppingCardRepo _shoppingCardRepo;

  FutureOr<void> _addToCard(ShoppingCardAddProductEvent event,
      Emitter<ShoppingCardState> emit) async {
    emit(state.copyWith(status: BlocStatus.adding));
    try {
      ProductLine? line = await _shoppingCardRepo.addToCard(
          product: event.product, quantity: event.quantity);
      if (line != null && line.id != null) {
        state.productLines.add(line);
        emit(state.copyWith(status: BlocStatus.added));
      } else {
        emit(state.copyWith(status: BlocStatus.addfailed));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.addfailed));
    }
  }

  FutureOr<void> _removeFromCard(ShoppingCardRemoveProductEvent event,
      Emitter<ShoppingCardState> emit) async {
    emit(state.copyWith(status: BlocStatus.deleting));
    try {
      bool removed =
          await _shoppingCardRepo.removeFromCard(product: event.product);
      if (!removed) {
        emit(state.copyWith(
            status: BlocStatus.deletefailed,
            error: 'Error Removing Product from Card'));
      } else {
        emit(state.copyWith(status: BlocStatus.deleted));
      }
    } catch (e) {}
  }

  FutureOr<void> _updateQuantiry(ShoppingCardUpdateQuantityEvent event,
      Emitter<ShoppingCardState> emit) async {}
}
