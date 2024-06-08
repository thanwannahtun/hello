import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const Text('Database Suggesstion ( Note )'));
}

/// [ChatGPT]  https://chatgpt.com/c/3d9cea15-543f-4a44-ae4a-17a5a9018cbe

/*
Foreign key constraints မသုံးဘဲ SalesOrder နဲ့ OrderItem တို့ရဲ့ အဆက်အသွယ်တွေကို handle လုပ်ချင်တဲ့အခါမှာ 
application level မှာ logic တွေကို ထည့်သွင်းရေးသားရမှာ ဖြစ်ပါတယ်။ 

ဒီနည်းလမ်းမှာ database ရဲ့ integrity (တည်ငြိမ်မှု) ကို application level မှာ ထိန်းသိမ်းရမှာဖြစ်ပါတယ်။

SalesOrder နဲ့ OrderItem Table Definitions
Foreign key constraints မပါအောင် tables တွေကို ဆောက်တည်ပုံက အောက်ပါအတိုင်း ဖြစ်ပါတယ်။

--------------------------------------------------------------------------------------------

CREATE TABLE SalesOrder (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(50),
    total_amount DECIMAL(10, 2),
    shipping_address TEXT,
    billing_address TEXT
);

CREATE TABLE OrderItem (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    total_price DECIMAL(10, 2)
);

--------------------------------------------------------------------------------------------

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
1. Inserting a New Sales Order with Order Items
SalesOrder နဲ့ OrderItem တွေကို Insert လုပ်တဲ့အခါမှာ 
transactions ကို အသုံးပြုပြီး consistency (အတူတကွတည်ရှိမှု) ကို ထိန်းသိမ်းနိုင်ပါတယ်။

--------------------------------------------------------------------------------------------
START TRANSACTION;

-- SalesOrder ကို insert လုပ်မယ်
INSERT INTO SalesOrder (customer_id, order_date, order_status, total_amount, shipping_address, billing_address)
VALUES (1, '2024-05-27', 'Pending', 100.00, '123 Shipping St', '456 Billing Ave');

-- နောက်ဆုံး insert လုပ်ခဲ့တဲ့ order_id ကို သိရန်
SET @last_order_id = LAST_INSERT_ID();

-- OrderItem တွေကို insert လုပ်မယ်
INSERT INTO OrderItem (order_id, product_id, quantity, unit_price, total_price)
VALUES (@last_order_id, 101, 2, 25.00, 50.00);

INSERT INTO OrderItem (order_id, product_id, quantity, unit_price, total_price)
VALUES (@last_order_id, 102, 1, 50.00, 50.00);

COMMIT;
--------------------------------------------------------------------------------------------
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

2. Deleting a Sales Order with Order Items
SalesOrder နဲ့ အတူ OrderItem တွေကိုပါ ဖျက်သိမ်းဖို့ transactions ကို အသုံးပြုနိုင်ပါတယ်။

--------------------------------------------------------------------------------------------

START TRANSACTION;

-- ပထမဆုံး သက်ဆိုင်တဲ့ OrderItem တွေကို ဖျက်မယ်
DELETE FROM OrderItem WHERE order_id = 1;

-- နောက်ဆုံးမှာ SalesOrder ကို ဖျက်မယ်
DELETE FROM SalesOrder WHERE order_id = 1;

COMMIT;

--------------------------------------------------------------------------------------------
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

3. Updating a Sales Order
SalesOrder ကို Update လုပ်တဲ့အခါ သက်ဆိုင်တဲ့ OrderItem တွေကို Update လုပ်ရနိုင်ပါတယ်။
သို့သော် အများအားဖြင့် order_id ကို update လုပ်ဖို့ မလိုအပ်ပါဘူး။

--------------------------------------------------------------------------------------------

UPDATE SalesOrder
SET 
    order_status = 'Completed',
    total_amount = 120.00,
    shipping_address = '789 New Shipping St'
WHERE 
    order_id = 1;

--------------------------------------------------------------------------------------------
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

ထထထထထထထထထထထထထထထထထထထထထထထထထထထထထထထ

-Inserting a New Sales Order with Order Items

Future<void> insertSalesOrder(Map<String, dynamic> salesOrder, List<Map<String, dynamic>> orderItems) async {
  final db = await getDatabase();
  await db.transaction((txn) async {
    int orderId = await txn.insert('SalesOrder', salesOrder);
    for (var item in orderItems) {
      item['order_id'] = orderId;
      await txn.insert('OrderItem', item);
    }
  });
}

-Reading Sales Orders and Order Items

Future<List<Map<String, dynamic>>> getSalesOrder(int orderId) async {
  final db = await getDatabase();

  List<Map<String, dynamic>> salesOrder = await db.query(
    'SalesOrder',
    where: 'order_id = ?',
    whereArgs: [orderId],
  );

  if (salesOrder.isNotEmpty) {
    List<Map<String, dynamic>> orderItems = await db.query(
      'OrderItem',
      where: 'order_id = ?',
      whereArgs: [orderId],
    );
    salesOrder.first['order_items'] = orderItems;
  }

  return salesOrder;
}

-Updating a Sale Order

Future<void> updateSalesOrder(int orderId, Map<String, dynamic> salesOrder) async {
  final db = await getDatabase();
  await db.update(
    'SalesOrder',
    salesOrder,
    where: 'order_id = ?',
    whereArgs: [orderId],
  );
}

-Deleting a Sales Order with Order Items

Future<void> deleteSalesOrder(int orderId) async {
  final db = await getDatabase();
  await db.transaction((txn) async {
    await txn.delete(
      'OrderItem',
      where: 'order_id = ?',
      whereArgs: [orderId],
    );
    await txn.delete(
      'SalesOrder',
      where: 'order_id = ?',
      whereArgs: [orderId],
    );
  });
}

-EXAMPLE USAGE 
[[[------------------------:

void main() async {
  // Insert a new sales order with order items
  await insertSalesOrder(
    {
      'customer_id': 1,
      'order_date': '2024-05-27',
      'order_status': 'Pending',
      'total_amount': 100.00,
      'shipping_address': '123 Shipping St',
      'billing_address': '456 Billing Ave'
    },
    [
      {'product_id': 101, 'quantity': 2, 'unit_price': 25.00, 'total_price': 50.00},
      {'product_id': 102, 'quantity': 1, 'unit_price': 50.00, 'total_price': 50.00}
    ],
  );

  // Read sales order with order items
  var salesOrder = await getSalesOrder(1);
  print(salesOrder);

  // Update a sales order
  await updateSalesOrder(1, {
    'order_status': 'Completed',
    'total_amount': 120.00,
    'shipping_address': '789 New Shipping St'
  });

  // Delete a sales order with order items
  await deleteSalesOrder(1);
}


:------------------------]]]


-----------------------------------------------------------------------------------------------------------
Foreign key constraints မသုံးဘဲ application level မှာ data integrity ကို ထိန်းသိမ်းဖို့ transactions ကို အသုံးပြုရပါမယ်။
-----------------------------------------------------------------------------------------------------------


*/