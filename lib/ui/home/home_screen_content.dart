import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kassual/models/product/filter.dart';
import 'package:kassual/ui/product/product_card.dart';
import 'package:kassual/ui/product/product_list_screen.dart';
import 'package:kassual/ui/widgets/app_bar.dart';
import 'package:kassual/ui/widgets/for_items_list.dart';
import 'package:kassual/ui/widgets/top_banner.dart';

class HomeScreenContent extends StatefulWidget {
  final List<Collection> collections;

  const HomeScreenContent({Key key, this.collections}) : super(key: key);
  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: KDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [KAppBar(title: "KASSUAL")],
        body: widget.collections.isEmpty
            ? Center(child: SpinKitFoldingCube(color: Colors.brown[300]))
            : buildBody(),
      ),
    );
  }

  List<String> get images => widget.collections
      .where((element) => element.image?.originalSource != null)
      .map((e) => e.image.originalSource)
      .toList();

  ListView buildBody() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        TopBanner(images: images),
        for (var c in widget.collections) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(c.title, style: titleText),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductLisScreen(
                          filter: Filter(collectionId: c.id),
                        ),
                      ),
                    );
                  },
                  child: Text("More"),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 1.2,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: c.products.productList
                  .map((e) => ProductCard(product: e))
                  .toList(),
            ),
          ),
          Divider(),
        ],
        detailsSection(),
      ],
    );
  }

  TextStyle get titleText {
    return TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  final padding = 20.0;

  detailsSection() {
    return ForItemsList(
      children: <Item>[
        Item(
          title: "Free delivery",
          data: "All U.S.A Orders are qualified for free delivery",
          image: SvgPicture.asset("assets/images/ship_outline.svg"),
        ),
        Item(
          title: "Payment Method",
          data:
              "We accept: Visa, MasterCard, Discover, American Express, PayPal, ApplePay, GooglePay",
          image: SvgPicture.asset("assets/images/credit_card.svg"),
        ),
        Item(
          title: "Returns and Refunds",
          data: "We accept returns within 30 days from delivery day",
          image: SvgPicture.asset("assets/images/return.svg"),
        ),
        Item(
          title: "Students Discount",
          data: "Student currently enroll receive 15% discount for 1 year",
          image: SvgPicture.asset("assets/images/discount.svg"),
        ),
      ],
      padding: 10,
    );
  }

  loading() {
    return Center(
      child: SpinKitCubeGrid(color: Colors.brown[300]),
    );
  }
}
