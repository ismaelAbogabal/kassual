import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kassual/bloc/cart_bloc/cart_bloc.dart';
import 'package:kassual/config/theme.dart';
import 'package:kassual/models/home_screen/home_screen_bloc.dart';
import 'package:kassual/models/product/product.dart';
import 'package:kassual/ui/cart/cart_screen.dart';
import 'package:kassual/ui/product/product_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, @required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: AspectRatio(
          aspectRatio: .6,
          child: buildCardContent(context),
        ),
      ),
    );
  }

  Column buildCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!product.available) buildTopButton(),
        Expanded(
          child: buildImage(),
        ),
        Text(
          product.brande,
          style: TextStyle(
            color: Colors.black.withAlpha(180),
            fontSize: 16,
          ),
        ),
        Text(product.name),
        buildPrice(),
        product.available ? buildAddtoCartButton(context) : buildOutOfStock(),
      ],
    );
  }

  buildOutOfStock() {
    return OutlineButton.icon(
      icon: SizedBox(),
      label: Text("Sold Out"),
      onPressed: null,
    );
  }

  buildAddtoCartButton(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: OutlineButton.icon(
        onPressed: () {
          CartBloc.of(context).add(CartEventAddProduct(product));
          HomeScreenBloc.of(context).add(HomeScreenSetIndex(2));
        },
        icon: SvgPicture.asset("assets/images/bag_outline_black.svg"),
        label: Text("Add to cart"),
      ),
    );
  }

  buildPrice() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 18),
        children: [
          if (product.realPrice != product.sellPrice)
            TextSpan(
              text: "\$ ${product.realPrice}",
              style: AppTheme.discountedTextStyle,
            ),
          TextSpan(text: "  \$ ${product.sellPrice}"),
        ],
      ),
    );
  }

  buildImage() {
    return Hero(
      //todo change to product id
      tag: product.image,
      child: Image.network(product.image),
    );
  }

  buildTopButton() {
    return Chip(
      label: Text("Out Stock"),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: Colors.brown,
      labelStyle: TextStyle(color: Colors.white),
    );
  }
}
