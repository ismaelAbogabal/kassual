import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/cart_bloc/cart_bloc.dart';
import 'package:kassual/bloc/home_screen/home_screen_bloc.dart';
import 'package:kassual/config/theme.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kassual/models/product/products_repository.dart';
import 'package:kassual/ui/product/product_card.dart';
import 'package:kassual/ui/widgets/app_bar.dart';
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

  ProductVariant selectedVariant;

  @override
  void initState() {
    ProductRepository.recommendationProducts(widget.product.id).then((value) {
      setState(() {
        products = value;
      });
    });
    selectedVariant = widget.product.productVariants.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          KAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                images(),
                title(),
                if (widget.product.productVariants.length > 1) variantsBar(),
                price(),
                addToCart(context),
                discription(),
                if (products != null) relatedProductsTitle(),
                if (products != null) relatedProducts()
              ],
            ),
          ),
        ],
      ),
    );
  }

  AspectRatio relatedProducts() {
    return AspectRatio(
      aspectRatio: 1,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: products
            .map((e) => ProductCard(product: e, withHero: true))
            .toList(),
      ),
    );
  }

  Padding relatedProductsTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 10),
      child: Text(
        "Related Products",
        style: TextStyle(fontFamily: "krona"),
      ),
    );
  }

  Padding discription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HtmlWidget(
        widget.product.descriptionHtml,
        onTapUrl: (u) => launch(u),
      ),
    );
  }

  Padding addToCart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        colorBrightness: Brightness.dark,
        onPressed: !widget.product.availableForSale
            ? null
            : () {
                HomeScreenBloc.of(context).add(HomeScreenSetScreen(2));
                CartBloc.of(context).add(
                  CartEventAddProduct(selectedVariant.id, context),
                );
                Navigator.pop(context);
              },
        child: Text("ADD TO CART"),
      ),
    );
  }

  Padding price() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 18),
          children: [
            if (selectedVariant.compareAtPrice.amount != null &&
                selectedVariant.compareAtPrice.amount !=
                    selectedVariant.price.amount)
              TextSpan(
                text: "${selectedVariant.compareAtPrice.formattedPrice}",
                style: AppTheme.discountedTextStyle,
              ),
            TextSpan(
              text: "  ${selectedVariant?.price?.formattedPrice}",
            ),
          ],
        ),
      ),
    );
  }

  variantsBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        for (var variant in widget.product.productVariants)
          ChoiceChip(
            onSelected: (a) => setState(() => selectedVariant = variant),
            selected: variant == selectedVariant,
            label: Text(variant.title),
          ),
      ],
    );
  }

  Padding title() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.product.title),
    );
  }

  images() {
    List<ShopifyImage> images;
    if (widget.product.productVariants.length > 1) {
      images = [selectedVariant.image];
    } else {
      images = widget.product.images;
    }
    return AspectRatio(
      aspectRatio: 1,
      child: Hero(
        tag: widget.product.id,
        child: Stack(
          children: [
            PageView(
              controller: imagesController,
              children: images
                  .map(
                    (e) => Image.network(e.originalSource),
                  )
                  .toList(),
            ),
            Align(
              alignment: Alignment(0, 1),
              child: SmoothPageIndicator(
                controller: imagesController,
                count: images.length,
                effect: ScrollingDotsEffect(
                  fixedCenter: true,
                  radius: 5,
                  dotColor: Colors.black38,
                  activeDotColor: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
