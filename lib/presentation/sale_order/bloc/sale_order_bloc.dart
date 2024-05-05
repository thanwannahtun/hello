import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sale_order_event.dart';
part 'sale_order_state.dart';

class SaleOrderBloc extends Bloc<SaleOrderEvent, SaleOrderState> {
  SaleOrderBloc() : super(SaleOrderInitial()) {
    on<SaleOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
