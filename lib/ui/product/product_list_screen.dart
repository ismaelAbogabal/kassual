import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kassual/models/product/filter.dart';
import 'package:kassual/models/product/product.dart';
import 'package:kassual/models/product/products_repository.dart';
import 'package:kassual/ui/product/product_card.dart';
import 'package:kassual/ui/widgets/app_bar.dart';

class ProductLisScreen extends StatefulWidget {
  final Filter filter;

  const ProductLisScreen({Key key, this.filter}) : super(key: key);

  @override
  _ProductLisScreenState createState() => _ProductLisScreenState();
}

class _ProductLisScreenState extends State<ProductLisScreen> {
  List<Product> products;
  bool gettingData = false;
  String _lastProductCursor;

  ScrollController scrollController = ScrollController(keepScrollOffset: true);

  @override
  void initState() {
    // scrollController.addListener(() {
    //   if (!gettingData &&
    //       scrollController.position.maxScrollExtent - scrollController.offset <
    //           100) {
    //     getProducts();
    //   }
    // });
    getProducts();
    super.initState();
  }

  getProducts() async {
    setState(() {
      gettingData = true;
    });
    if (widget.filter.collectionId != null) {
      products = await ProductRepository.collectionProducts(
        widget.filter.collectionId,
      );
      setState(() {
        gettingData = false;
      });
    } else {
      var _products = await ProductRepository.productsWithFilter(
        widget.filter,
        lastCursor: _lastProductCursor,
        lastCursorSetter: (c) => _lastProductCursor = c,
      ).catchError((e) {
        setState(() {
          gettingData = false;
        });
      });
      products ??= [];
      setState(() {
        products.addAll(_products);
        gettingData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(title: Text("KASSUAL")),
          SliverGrid.count(
              childAspectRatio: .5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: (products ?? [])
                  .map<Widget>((e) => ProductCard(product: e))
                  .toList()),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 50,
              child: gettingData
                  ? SpinKitFoldingCube(color: Colors.brown[300])
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  NestedScrollView buildNestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        KAppBar(title: "KASSUAL"),
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
            if (products.last == e) {
            }
            return ProductCard(product: e);
          }).toList()),
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
