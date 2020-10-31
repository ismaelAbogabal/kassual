import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';

class OrderItemWidget extends StatelessWidget {
  final LineItemOrder item;

  OrderItemWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Item:  ${item.title}"),
              // Text("Brand: ${item.brande}"),
              Row(
                children: [
                  Text("Count: "),
                  Text("${item.quantity}"),
                ],
              ),
              Text("Price: ${item.variant.price.formattedPrice}\$")
            ],
          ),
        ),
        Expanded(child: Image.network(item.variant.image.originalSource)),
      ],
    );
  }
}

