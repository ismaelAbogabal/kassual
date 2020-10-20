import 'package:flutter/material.dart';
import 'package:kassual/bloc/cart_bloc/cart_bloc.dart';
import 'package:kassual/config/theme.dart';
import 'package:kassual/models/product/product.dart';
import 'package:kassual/ui/cart/cart_screen.dart';
import 'package:kassual/ui/widgets/for_items_list.dart';

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
            child: Text(widget.product.name),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  if (widget.product.realPrice != widget.product.sellPrice)
                    TextSpan(
                      text: "\$ ${widget.product.realPrice}",
                      style: AppTheme.discountedTextStyle,
                    ),
                  TextSpan(text: "  \$ ${widget.product.sellPrice}"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              colorBrightness: Brightness.dark,
              onPressed: !widget.product.available
                  ? null
                  : () {
                      CartBloc.of(context)
                          .add(CartEventAddProduct(widget.product));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    },
              child: Text("ADD TO CART"),
            ),
          ),
          buildExpansionPanelList(),
        ],
      ),
    );
  }

  int expandedIndex;

  ExpansionPanelList buildExpansionPanelList() {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          if (!isExpanded) {
            expandedIndex = panelIndex;
          } else {
            expandedIndex = null;
          }
        });
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) => ListTile(title: Text("Size")),
          isExpanded: expandedIndex == 0,
          body: detailsSection(),
        ),
        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) =>
              ListTile(title: Text("Description")),
          isExpanded: expandedIndex == 1,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.description),
          ),
        ),
      ],
    );
  }

  images() {
    return AspectRatio(
      aspectRatio: 1,
      child: Hero(
        tag: widget.product.image,
        child: PageView(
          children: widget.product.images.map((e) => Image.network(e)).toList(),
        ),
      ),
    );
  }

  final padding = 20.0;

  detailsSection() {
    return ForItemsList(children: [
      Item(
        title: "Length Width",
        data: "${widget.product.lengthWidth}",
        image: Image.asset("assets/images/size/width.jpg"),
      ),
      Item(
        title: "Length Height",
        data: "${widget.product.lengthHeight}",
        image: Image.asset("assets/images/size/height.jpg"),
      ),
      Item(
        title: "Temple",
        data: "${widget.product.temple}",
        image: Image.asset("assets/images/size/temple.jpg"),
      ),
      Item(
        title: "Bridge",
        data: "${widget.product.bridge}",
        image: Image.asset("assets/images/size/bridge.jpg"),
      ),
    ]);
  }
}
