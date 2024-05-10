import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/presentation/sale_order/repo/sale_order_repo.dart';

part 'sale_order_event.dart';
part 'sale_order_state.dart';

class SaleOrderBloc extends Bloc<SaleOrderEvent, SaleOrderState> {
  SaleOrderBloc()
      : _saleOrderRepo = SaleOrderRepo(),
        super(
            const SaleOrderState(saleOrders: [], status: BlocStatus.initial)) {
    on<SaleOrderGetAllEvent>(_getAllSaleOrders);
    on<SaleOrderCreateEvent>(_createSaleOrders);
  }

  final SaleOrderRepo _saleOrderRepo;
  FutureOr<void> _getAllSaleOrders(
      SaleOrderGetAllEvent event, Emitter<SaleOrderState> emit) async {
    emit(state.copyWith(status: BlocStatus.fetching));
    try {
      List<SaleOrder> saleOrders = await _saleOrderRepo.getAllSaleOrders();
      emit(state.copyWith(status: BlocStatus.fetched, saleOrders: saleOrders));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.fetched, error: e.toString()));
    }
  }

  FutureOr<void> _createSaleOrders(
      SaleOrderCreateEvent event, Emitter<SaleOrderState> emit) async {
    emit(state.copyWith(status: BlocStatus.adding));
    try {
      SaleOrder? saleOrder = await _saleOrderRepo.addSaleOrderAndGetaddedOrder(
          saleOrder: event.saleOrder);

      if (saleOrder != null) {
        state.saleOrders.add(saleOrder);
        emit(state.copyWith(status: BlocStatus.added));
      } else {
        emit(state.copyWith(
            status: BlocStatus.addfailed,
            error: 'Failed creating new Sale Order ${event.saleOrder.soNo}'));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.addfailed, error: e.toString()));
    }
  }
}
