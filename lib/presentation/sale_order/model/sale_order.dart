import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hello/presentation/sale_order/model/sale_order_line.dart';

class SaleOrder {
  SaleOrder(
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
      this.salePerson});

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
  final String? salePerson;

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
      salePerson: json['salePerson'],
      township: json['township'],
      ward: json['ward'],
      phone: json['phone'],
      customerName: json['customerName'],
      cutomerId: json['cutomerId'],
      saleOrderLines: saleOrderLines,

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
    map['salePerson'] = salePerson;
    map['township'] = township;
    map['ward'] = ward;
    map['phone'] = phone;
    map['customerName'] = customerName;
    map['cutomerId'] = cutomerId;
    map['saleOrderLines'] = saleOrderLines != null
        ? saleOrderLines?.map((e) => e.toJson()).toList()
        : [];
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
      String? salePerson}) {
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
        salePerson: salePerson ?? salePerson);
  }
}