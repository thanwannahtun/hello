import 'package:hello/core/utils/entity.dart';
import 'package:hello/presentation/sale_order/model/sale_order_line.dart';

class SaleOrder extends Entity {
  const SaleOrder(
      {this.id,
      this.soNo,
      this.orderType,
      this.orderDate,
      this.deliveryStatus,
      this.saleOrderLines,
      this.cutomerId,
      this.customerName,
      this.phone,
      this.ward,
      this.township,
      this.salePersonName,
      this.salePersonId})
      : super(entityId: id, entityName: soNo);

  final int? id;
  final String? soNo;
  final String? orderType;
  final String? orderDate;
  final String? deliveryStatus;
  final List<SaleOrderLine>? saleOrderLines;
  final int? cutomerId;
  final String? customerName;
  final String? phone;
  final String? ward;
  final String? township;
  final String? salePersonId;
  final String? salePersonName;

  factory SaleOrder.fromJson(Map<String, dynamic> json) {
    List<SaleOrderLine> saleOrderLines = [];
    for (var line in json['sale_order_line']) {
      saleOrderLines.add(SaleOrderLine.fromJson(line));
    }
    return SaleOrder(
      id: json['id'],
      soNo: json['soNo'],
      orderType: json['orderType'],
      orderDate: json['orderDate'],
      deliveryStatus: json['deliveryStatus'],
      salePersonId: json['salePersonId'],
      salePersonName: json['salePersonName'],
      township: json['township'],
      ward: json['ward'],
      phone: json['phone'],
      customerName: json['customerName'],
      cutomerId: json['cutomerId'],
      // saleOrderLines: saleOrderLines,
      saleOrderLines: const [], // FROM LINE

      // saleOrderLines: (json['saleOrderLines'] as List).map(orderLine => SaleOrderLine.fromJson(orderLine)).toList,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['soNo'] = soNo;
    map['orderType'] = orderType;
    map['orderDate'] = orderDate;
    map['deliveryStatus'] = deliveryStatus;
    map['salePersonId'] = salePersonId;
    map['salePersonName'] = salePersonName;
    map['township'] = township;
    map['ward'] = ward;
    map['phone'] = phone;
    map['customerName'] = customerName;
    map['cutomerId'] = cutomerId;
    // map['saleOrderLines'] = saleOrderLines != null
    //     ? saleOrderLines?.map((e) => e.toJson()).toList()
    //     : [];
    return map;
  }

  SaleOrder copyWith(
      {int? id,
      String? soNo,
      String? orderType,
      String? orderDate,
      String? deliveryStatus,
      List<SaleOrderLine>? saleOrderLines,
      int? cutomerId,
      String? customerName,
      String? phone,
      String? ward,
      String? township,
      String? salePersonId,
      String? salePersonName}) {
    return SaleOrder(
        id: id ?? this.id,
        soNo: soNo ?? this.soNo,
        orderType: orderType ?? this.orderType,
        orderDate: orderDate ?? this.orderDate,
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        saleOrderLines: saleOrderLines ?? saleOrderLines,
        cutomerId: cutomerId ?? cutomerId,
        customerName: customerName ?? customerName,
        phone: phone ?? phone,
        ward: ward ?? ward,
        township: township ?? township,
        salePersonId: salePersonId ?? salePersonId,
        salePersonName: salePersonName ?? salePersonName);
  }

  @override
  List<Object?> get props => [
        id,
        soNo,
        orderType,
        orderDate,
        deliveryStatus,
        saleOrderLines,
        cutomerId,
        customerName,
        phone,
        ward,
        township,
        salePersonId,
        salePersonName
      ];

  double getTotalSaleOrderLineAmount() {
    if (saleOrderLines == null && saleOrderLines!.isEmpty) {
      return 0.0;
    }
    return saleOrderLines!.fold(0,
        (previousValue, element) => previousValue + (element.subtotal ?? 0.0));
  }
}
