part of 'shopping_card_bloc.dart';

class ShoppingCardState extends Equatable {
  ShoppingCardState(
      {required this.status, required this.productLines, this.error});
  final BlocStatus status;
  final List<ProductLine> productLines;
  String? error;

  ShoppingCardState copyWith(
      {BlocStatus? status, List<ProductLine>? cards, String? error}) {
    return ShoppingCardState(
        status: status ?? this.status,
        productLines: cards ?? productLines,
        error: error ?? this.error);
  }

  @override
  String toString() {
    return 'ShoppingCardState{status=$status, cards=$productLines, error=$error}';
  }

  @override
  List<Object?> get props => [status, productLines, error];
}
