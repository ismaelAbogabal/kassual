import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kassual/bloc/cart_bloc/cart_bloc.dart';
import 'package:kassual/models/alert.dart';
import 'package:kassual/models/product/product.dart';

// ignore: must_be_immutable
class CartItemWidget extends StatelessWidget {
  final Product item;
  final int count;

  BuildContext _context;

  CartItemWidget({
    Key key,
    @required this.item,
    @required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [deleteButton(context)],
        child: Padding(
          padding: EdgeInsets.all(8),
          child: slidableItem,
        ),
      ),
    );
  }

  get slidableItem {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Item:  ${item.name}"),
              Text("Brand: ${item.brande}"),
              Row(
                children: [
                  Text("Count: "),
                  reduceBtn(),
                  Text("$count"),
                  addBtn(),
                ],
              ),
              Text("Price: ${item.sellPrice}\$")
            ],
          ),
        ),
        Expanded(child: Image.network(item.image)),
      ],
    );
  }

  IconButton addBtn() {
    return IconButton(
        icon: Icon(Icons.add_circle_outline),
        onPressed: () {
          CartBloc.of(_context).add(
            CartEventChangeCount(item, count + 1),
          );
        });
  }

  IconButton reduceBtn() {
    return IconButton(
      icon: Icon(Icons.remove_circle_outline),
      onPressed: () {
        if (count > 1)
          CartBloc.of(_context).add(
            CartEventChangeCount(item, count - 1),
          );
      },
    );
  }

  GestureDetector deleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool confirm = await AlertModel.confirm(
          context: context,
          title: "Deleting item",
          body: "Are you sure not to buy this item",
        );

        if (confirm) {
          CartBloc.of(context).add(CartEventRemoveProduct(item));
        }
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
