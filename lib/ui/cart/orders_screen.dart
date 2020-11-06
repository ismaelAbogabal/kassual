import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/models/cart/cart_repository.dart';
import 'package:kassual/ui/cart/order_item.dart';
import 'package:kassual/ui/widgets/loading_widget.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders;

  @override
  void initState() {
    CartRepository.allOrders().then((value) => setState(() => orders = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: orders == null ? LoadingWidget() : loadedState(orders),
    );
  }

  loadedState(List<Order> orders) {
    return ExpansionPanelList(
      children: [
        for (var o in orders)
          ExpansionPanel(
            headerBuilder: (context, isExpanded) => Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order: ${o.orderNumber}"),
                  Text("Date: ${o.processedAt}"),
                ],
              ),
            ),
            body: Column(
              children: [
                for (var item in o.lineItems.lineItemOrderList)
                  OrderItemWidget(item: item),
              ],
            ),
          ),
      ],
    );
  }


}
