import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/models/src/product.dart';
import 'package:kassual/models/product/filter.dart';
import 'package:kassual/models/product/products_repository.dart';
import 'package:kassual/ui/product/filter_screen.dart';
import 'package:kassual/ui/product/product_card.dart';
import 'package:kassual/ui/widgets/app_bar.dart';
import 'package:kassual/ui/widgets/loading_widget.dart';

class ProductLisScreen extends StatefulWidget {
  final Filter filter;

  const ProductLisScreen({Key key, this.filter}) : super(key: key);

  @override
  _ProductLisScreenState createState() => _ProductLisScreenState();
}

class _ProductLisScreenState extends State<ProductLisScreen> {
  Filter filter;
  List<Product> products;
  bool gettingData = false;
  String _lastProductCursor;

  ScrollController scrollController = ScrollController(keepScrollOffset: true);

  @override
  void initState() {
    filter = widget.filter;
    getProducts();
    scrollController.addListener(
      () {
        if (!gettingData &&
            (scrollController.offset -
                        scrollController.position.maxScrollExtent)
                    .abs() <
                20) {
          getProducts();
        }
      },
    );
    super.initState();
  }

  getProducts() async {
    setState(() {
      gettingData = true;
    });

    var _products = await ProductRepository.productsWithFilter(
      filter,
      lastCursor: _lastProductCursor,
      lastCursorSetter: (s) {
        _lastProductCursor = s;
      },
    );

    setState(() {
      products ??= [];
      products.addAll(_products ?? []);
      if (products.isNotEmpty) _lastProductCursor = products.last.cursor;
      gettingData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null || (products.isEmpty && gettingData)
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: LoadingWidget(),
            )
          : CustomScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                KAppBar(
                  action: buildFilterButton(context),
                ),
                SliverGrid.count(
                    childAspectRatio: .5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: (products ?? [])
                        .map<Widget>((e) => ProductCard(
                              product: e,
                              withHero: true,
                            ))
                        .toList()),
                if (gettingData)
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      child: LoadingWidget(),
                    ),
                  ),
                if (!gettingData && products.isEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height -
                          2 * kToolbarHeight,
                      child: Center(
                        child: Image.asset("assets/images/no_products.png"),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  buildFilterButton(BuildContext context) {
    return filter.collectionId != null
        ? Container()
        : IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () async {
              var _filter = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterScreen(
                    filter: filter,
                  ),
                ),
              );

              if (_filter is Filter) {
                products = [];
                _lastProductCursor = null;
                filter = _filter;
                getProducts();
              }
            },
          );
  }

  NestedScrollView buildNestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        KAppBar(),
      ],
      body: GridView.count(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          childAspectRatio: .5,
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: products.map<Widget>((e) {
            return ProductCard(product: e);
          }).toList()),
    );
  }
}
