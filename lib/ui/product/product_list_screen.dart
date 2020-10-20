import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kassual/models/product/product.dart';
import 'package:kassual/ui/product/product_card.dart';
import 'package:kassual/ui/widgets/app_bar.dart';

class ProductLisScreen extends StatelessWidget {
  final List<Product> products;

  const ProductLisScreen({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [KAppBar(title: "KASSUAL")],
        body: GridView.count(
          physics: BouncingScrollPhysics(),
          childAspectRatio: .5,
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: products.map((e) => ProductCard(product: e)).toList(),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("KASSUAL"),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/images/filter_outline.svg"),
          onPressed: () {},
        )
      ],
    );
  }
}
