import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kassual/bloc/cart_bloc/cart_bloc.dart';
import 'package:kassual/config/theme.dart';
import 'package:kassual/bloc/home_screen/home_screen_bloc.dart';
import 'package:kassual/ui/product/product_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool withHero;

  const ProductCard({
    Key key,
    @required this.product,
    this.withHero = false,
  }) : super(key: key);
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
        if (!product.availableForSale) buildTopButton(),
        Expanded(
          child: buildImage(),
        ),
        Text(
          product.vendor,
          style: TextStyle(
            color: Colors.black.withAlpha(180),
            fontSize: 16,
          ),
        ),
        Text(product.title),
        buildPrice(),
        product.availableForSale
            ? buildAddToCartButton(context)
            : buildOutOfStock(),
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

  buildAddToCartButton(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: OutlineButton.icon(
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          CartBloc.of(context).add(
              CartEventAddProduct(product.productVariants.first.id, context));
          HomeScreenBloc.of(context).add(HomeScreenSetScreen(2));
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
          if (product.productVariants.first?.price?.amount !=
              product.productVariants.first?.compareAtPrice?.amount)
            TextSpan(
              text:
                  "\$ ${product.productVariants.first?.compareAtPrice?.amount ?? ""}",
              style: AppTheme.discountedTextStyle,
            ),
          TextSpan(
              text: "  \$ ${product.productVariants.first?.price?.amount}"),
        ],
      ),
    );
  }

  buildImage() {
    Widget image = Image.network(product.images.first.originalSource);
    if (withHero) {
      image = Hero(
        tag: product.id,
        child: image,
      );
    }

    return image;
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
