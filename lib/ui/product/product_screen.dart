import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/cart_bloc/cart_bloc.dart';
import 'package:kassual/bloc/home_screen/home_screen_bloc.dart';
import 'package:kassual/config/theme.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({Key key, this.product}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: KAppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          images(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.title),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  if (widget.product.productVariants.first.price.amount !=
                      widget.product.productVariants.first.price.amount)
                    TextSpan(
                      text:
                          "\$ ${widget.product.productVariants.first?.compareAtPrice?.amount}",
                      style: AppTheme.discountedTextStyle,
                    ),
                  TextSpan(
                      text:
                          "  \$ ${widget.product.productVariants.first?.price?.amount}"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              colorBrightness: Brightness.dark,
              onPressed: !widget.product.availableForSale
                  ? null
                  : () {
                      HomeScreenBloc.of(context).add(HomeScreenSetScreen(2));
                      CartBloc.of(context).add(
                        CartEventAddProduct(
                          widget.product.productVariants.first.id,
                          context,
                        ),
                      );
                      Navigator.pop(context);
                    },
              child: Text("ADD TO CART"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              widget.product.descriptionHtml,
              onTapUrl: (u) => launch(u),
            ),
          ),
        ],
      ),
    );
  }

  images() {
    return AspectRatio(
      aspectRatio: 1,
      child: Hero(
        tag: widget.product.id,
        child: PageView(
          children: widget.product.images
              .map((e) => Image.network(e.originalSource))
              .toList(),
        ),
      ),
    );
  }
}
