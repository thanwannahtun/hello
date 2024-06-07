import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/presentation/purchase/model/purchase.dart';
import 'purchase_event.dart';
import 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final CRUDTable databaseHelper;

  PurchaseBloc({required this.databaseHelper}) : super(PurchaseInitial()) {
    on<AddPurchase>((event, emit) => _mapAddPurchaseToState(event));
  }
  

  // @override
  // Stream<PurchaseState> mapEventToState(PurchaseEvent event) async* {
  //   if (event is LoadPurchases) {
  //     yield* _mapLoadPurchasesToState();
  //   } else if (event is AddPurchase) {
  //     yield* _mapAddPurchaseToState(event);
  //   }
  // }

  // Stream<PurchaseState> _mapLoadPurchasesToState() async* {
  //   yield PurchaseLoading();
  //   try {
  //     final purchases = await databaseHelper.readData('Purchases');
  //     yield PurchaseLoaded(purchases: purchases);
  //   } catch (e) {
  //     yield PurchaseError(message: e.toString());
  //   }
  // }

  Stream<PurchaseState> _mapAddPurchaseToState(AddPurchase event) async* {
    try {
      // await databaseHelper.insertData('Purchases', {
      //   'product_id': event.productId,
      //   'vendor_id': event.vendorId,
      //   'quantity': event.quantity,
      //   'purchase_date': event.purchaseDate.toIso8601String(),
      // });
      // add(LoadPurchases());
      Purchase purchase = Purchase(
          productId: event.productId,
          vendorId: event.vendorId,
          quantity: event.quantity,
          purchaseDate: event.purchaseDate);
      emit(PurchaseLoaded(purchases: [purchase.toJson()]));
    } catch (e) {
      yield PurchaseError(message: e.toString());
    }
  }


}
