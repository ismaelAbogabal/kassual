import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/models/product/filter.dart';
import 'package:kassual/ui/product/product_list_screen.dart';
import 'package:kassual/ui/product/product_screen.dart';
import 'package:kassual/ui/search_screen.dart';
import 'package:kassual/ui/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class HomeScreenContent extends StatefulWidget {
  final Product card;

  const HomeScreenContent({
    Key key,
    this.card,
  }) : super(key: key);
  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent>
    with SingleTickerProviderStateMixin {
  TabController controller;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          KAppBar(pinned: false),
          SliverAppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            pinned: true,
            bottom: TabBar(
              controller: controller,
              isScrollable: true,
              tabs: [
                Tab(text: "MEN"),
                Tab(text: "WOMEN"),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: controller,
          children: [
            ListView(
              children: [
                buildCard(
                  title: "New Arrival",
                  subtitle: "Shop now",
                  image:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSHbbCmRnpl_7EdIT8sNDUqjBFWQRwfP0gg2w&usqp=CAU",
                  route: ProductLisScreen(
                    filter: Filter(collectionId: newArrivalCollectionId),
                  ),
                ),
                buildCard(
                  title: "Men Sunglasses",
                  subtitle: "Shop now",
                  image: "assets/images/home_screen/men_sun.jpg",
                  route: ProductLisScreen(
                    filter: Filter(collectionId: menSunglassesCollectionId),
                  ),
                ),
                buildCard(
                  title: "Men Eyeglasses",
                  subtitle: "Shop now",
                  image: "assets/images/home_screen/men_eye.jpg",
                  route: ProductLisScreen(
                    filter: Filter(collectionId: menEyeglassesCollectionId),
                  ),
                ),
                card(),
                contactInfo(),
              ],
            ),
            ListView(
              children: [
                buildCard(
                  title: "New Arrival",
                  subtitle: "Shop now",
                  image:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSHbbCmRnpl_7EdIT8sNDUqjBFWQRwfP0gg2w&usqp=CAU",
                  route: ProductLisScreen(
                    filter: Filter(collectionId: newArrivalCollectionId),
                  ),
                ),
                buildCard(
                  title: "Women Sunglasses",
                  subtitle: "Shop now",
                  image: "assets/images/home_screen/women_sun.jpg",
                  route: ProductLisScreen(
                    filter: Filter(collectionId: womenSunglassesCollectionId),
                  ),
                ),
                buildCard(
                  title: "Women Eyeglasses",
                  subtitle: "Shop now",
                  image: "assets/images/home_screen/women_eye.jpg",
                  route: ProductLisScreen(
                    filter: Filter(collectionId: womenEyeglassesCollectionId),
                  ),
                ),
                card(),
                contactInfo(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card() {
    return buildCard(
      title: "Gift Card",
      subtitle: "Shop now",
      image: widget.card.images.first.originalSource,
      heroTag: widget.card.id,
      route: ProductScreen(product: widget.card),
    );
  }

  Widget buildCard({
    String image,
    String title,
    String subtitle,
    String heroTag,
    Widget route,
  }) {
    return GestureDetector(
      onTap: () {
        if (route == null) return;
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return route;
          },
        ));
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: heroTag ?? image,
              child: image.contains("assets")
                  ? Image.asset(
                      image,
                      height: 200,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      image,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Center(child: Text(subtitle)),
          ],
        ),
      ),
    );
  }

  contactInfo() {
    return ExpansionTile(
      backgroundColor: Colors.black,
      title: Text('Contact Us'),
      children: [
        ListTile(
          leading: Icon(Icons.phone, color: Colors.white),
          onTap: () {
            url.launch("tel:8189133305");
          },
          title: Text(
            "818-913-3305",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.mail_outline, color: Colors.white),
          onTap: () {
            url.launch("mailto:info@kassual.com");
          },
          title: Text(
            "Send us an email",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
