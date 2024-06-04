import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hello/presentation/bloc/bloc_status.dart';
import 'package:hello/presentation/sale_order/model/sale_order.dart';
import 'package:hello/presentation/sale_order/model/sale_order_line.dart';
// import 'package:hello/presentation/sale_order/repo/sale_order_repo.dart';
import 'package:hello/presentation/sale_order/repo/sale_order_repository.dart';

part 'sale_order_event.dart';
part 'sale_order_state.dart';

class SaleOrderBloc extends Bloc<SaleOrderEvent, SaleOrderState> {
  SaleOrderBloc()
      : _saleOrderRepo = SaleOrderRepository(),
        super(const SaleOrderState(
            saleOrders: [], orderLines: [], status: BlocStatus.initial)) {
    on<SaleOrderGetAllEvent>(_getAllSaleOrders);
    on<SaleOrderCreateEvent>(_createSaleOrders);
    // on<SaleOrderCreateEvent>(_createSaleOrder);
    on<AddOrderLineEvent>(_addOrderLine);
    on<RemoveOrderLineEvent>(_removeOrderLine);
    on<UpdateOrderLineEvent>(_updateOrderLine);

    on<AddCurrentOrderLineEvent>(_addCurrentOrderLines);
  }

  final SaleOrderRepository _saleOrderRepo;
  FutureOr<void> _getAllSaleOrders(
      SaleOrderGetAllEvent event, Emitter<SaleOrderState> emit) async {
    emit(state.copyWith(status: BlocStatus.fetching));
    try {
      List<SaleOrder> saleOrders = await _saleOrderRepo.getAllSaleOrders();
      debugPrint('saleOrders length ::::: ${saleOrders.length}');
      emit(state.copyWith(status: BlocStatus.fetched, saleOrders: saleOrders));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.fetched, error: e.toString()));
    }
  }

  FutureOr<void> _createSaleOrders(
      SaleOrderCreateEvent event, Emitter<SaleOrderState> emit) async {
    emit(state.copyWith(status: BlocStatus.adding));
    try {
      // SaleOrder? saleOrder = await _saleOrderRepo.addSaleOrderAndGetAddedOrder(
      //     saleOrder: event.saleOrder, orderLines: event.orderLines);
      SaleOrder? saleOrder = await _saleOrderRepo.addSaleOrderAndGetAddedOrder(
          saleOrder: event.saleOrder);
      if (saleOrder != null) {
        state.saleOrders.add(saleOrder);

        emit(state.copyWith(status: BlocStatus.added));
        // state.orderLines.clear(); // clear the orderlines for next SO
      } else {
        emit(state.copyWith(
            status: BlocStatus.addfailed, error: "Failed Adding SO "));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.addfailed, error: e.toString()));
    }
  }

  /// add currentOrderLines to SaleOrder
  FutureOr<void> _addCurrentOrderLines(
      AddCurrentOrderLineEvent event, Emitter<SaleOrderState> emit) async {
    await _saleOrderRepo.addOrderlines(
        soId: event.saleOrderId, lines: event.orderLines);
  }

  /// add OrderLine to currentOrderLines
  FutureOr<void> _addOrderLine(
      AddOrderLineEvent event, Emitter<SaleOrderState> emit) async {
    // state.orderLines.add(event.orderLine);
    print('-----------before');
    [...state.orderLines, event.orderLine];
    print('-----------after ${[...state.orderLines, event.orderLine]}');
  }

  FutureOr<void> _updateOrderLine(
      UpdateOrderLineEvent event, Emitter<SaleOrderState> emit) async {
    // state.orderLines.add(event.orderLine);
    state.orderLines[state.orderLines
        .indexWhere((element) => element == event.orderLine)] = event.orderLine;
  }

  FutureOr<void> _removeOrderLine(
      RemoveOrderLineEvent event, Emitter<SaleOrderState> emit) async {
    state.orderLines.remove(event.orderLine);
  }
}

/*

1. add saleOrder first (return added saleOrder)

2. add orderLines to current orderLines state ( declare [orderLists] in UI for current orderLines )

3. comfirm => call AddCurrentOrderLineEvent ( id : current order id , orderLines : state.currentorderLine ( [orderLists] in UI ) );

*/