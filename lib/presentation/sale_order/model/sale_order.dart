import 'package:hello/presentation/sale_order/model/sale_order_line.dart';

class SaleOrder {
  SaleOrder(
      {required this.saleOrderLines,
      this.id,
      this.customerId,
      this.customerName,
      this.expirationDate,
      this.paymentTerm,
      this.currency});
  final int? id;
  final int? customerId;
  final String? customerName;
  final String? expirationDate;
  final String? paymentTerm;
  final String? currency;
  final List<SaleOrderLine> saleOrderLines;

  SaleOrder copyWith(
      {int? id,
      int? customerId,
      String? customerName,
      String? expirationDate,
      String? paymentTerm,
      String? currency,
      List<SaleOrderLine>? saleOrderLines}) {
    return SaleOrder(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        customerName: customerName ?? this.customerName,
        expirationDate: expirationDate ?? this.expirationDate,
        paymentTerm: paymentTerm ?? this.paymentTerm,
        currency: currency ?? this.currency,
        saleOrderLines: saleOrderLines ?? this.saleOrderLines);
  }

  factory SaleOrder.fromJson(Map<String, dynamic> json) {
    List<SaleOrderLine> saleOrderLines = [];
    for (var line in json['sale_order_line']) {
      saleOrderLines.add(SaleOrderLine.fromJson(line));
    }
    return SaleOrder(
        id: json['id'],
        customerId: json['customerId'],
        customerName: json['customerName'],
        expirationDate: json['expirationData'],
        paymentTerm: json['paymentTerm'],
        currency: json['currency'],
        saleOrderLines: saleOrderLines
        // saleOrderLines: (json['saleOrderLines'] as List).map(orderLine => SaleOrderLine.fromJson(orderLine)).toList(),
        );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['customer_id'] = customerId;
    map['customer_name'] = customerName;
    map['expiration_date'] = expirationDate;
    map['payment_term'] = paymentTerm;
    map['currency'] = currency;
    map['sale_order_lines'] = saleOrderLines;
    return map;
  }
}
