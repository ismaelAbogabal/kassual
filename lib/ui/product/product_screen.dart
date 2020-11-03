import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/cart_bloc/cart_bloc.dart';
import 'package:kassual/bloc/home_screen/home_screen_bloc.dart';
import 'package:kassual/config/theme.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kassual/models/product/products_repository.dart';
import 'package:kassual/ui/product/product_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final PageController imagesController = PageController();

  List<Product> products;

  @override
  void initState() {
    ProductRepository.recommendationProducts(widget.product.id).then((value) {
      setState(() {
        products = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("KASSUAL")),
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
                  if (widget.product.productVariants.first.compareAtPrice
                          .amount !=
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
          if (products != null)
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 10),
              child: Text(
                "Related Products",
                style: TextStyle(fontFamily: "krona"),
              ),
            ),
          if (products != null)
            AspectRatio(
              aspectRatio: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: products
                    .map((e) => ProductCard(product: e, withHero: true))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }

  images() {
    return AspectRatio(
      aspectRatio: 1,
      child: Hero(
        tag: widget.product.id,
        child: Stack(
          children: [
            PageView(
              controller: imagesController,
              children: widget.product.images
                  .map((e) => Image.network(e.originalSource))
                  .toList(),
            ),
            Align(
              alignment: Alignment(0, 1),
              child: SmoothPageIndicator(
                controller: imagesController,
                count: widget.product.images.length,
                effect: ScrollingDotsEffect(
                  fixedCenter: true,
                  radius: 5,
                  dotColor: Colors.brown[200],
                  activeDotColor: Colors.brown[300],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
