/*
SaleOrders ; << SaleOrders List Page >>


SaleOrder << SaleOrder Create Page >>
-OrderLines  << Order Line List View >>

/// for orderLine Event
addOrderLine -> state.orderLines.add(line);
updateOrderLine -> state.orderLines[...] = event.orderLine;
deleteOrderLine -> state.orderLines.remove(line);

/// for SaleOrderCreateEvent
[submit] => createSaleOrderEvent => { 
    SaleOrder(orderLines : state.orderLines);
    
    // clear orderLines
     state.orderLines.clear();
    
}

/// for SaleOrderUpdateEvent  [ delivery status , order state , etc... ]
state.saleOrders[...find SaleOrder ] = saleOrder;

/// 

 */

/*

//// #### for Database

    createSaleOrder(saleOrder){
      db.insert(saleOrder.toJson());
    }

    getSaleOrder(saleOrderId){
      /// from sketch_database
    }



*/

/*

/// for UI 
// for OrderLine
OrderLine orderLine = OrderLine(
  soId:?,
  otherInfo....
);
addOrderLine(orderLine);

xxxx
// for SaleOrder

SaleOrder saleOrder = SaleOrder();
<--

createSaleOrder(saleOrder);

clear(orderLine); // call event


-->
xxx
<--

fetchSaleOrders from DB
-display

-->
#1 creating SaleOrder with their orderlines
#2( by transaction ) OR ( by batch() ) ?
createSaleOrder(saleOrder){
  db.createSO( so : saleOrder , orderLines : state.orderLines );
  // logic here [ make relationship saleOrder'id on every orderLine's orderId ],

}


*/