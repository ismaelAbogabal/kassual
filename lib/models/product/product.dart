import 'package:flutter/foundation.dart';

class Product {
  final int id;
  final String brande, name, description;

  final double realPrice, sellPrice;

  final List<String> images;
  final bool available;
  final Map attributes;

  final int lengthWidth, lengthHeight, temple, bridge;

  Product({
    @required this.id,
    @required this.brande,
    @required this.name,
    @required this.description,
    @required this.realPrice,
    @required this.sellPrice,
    @required this.images,
    @required this.available,
    this.attributes,
    this.lengthWidth = 10,
    this.lengthHeight = 10,
    this.temple = 10,
    this.bridge = 10,
  });

  String get image => images.first;

  factory Product.fromJson(Map e) {
    return Product(
      id: e["id"],
      brande: e["vendor"],
      name: e["title"],
      description: e["body_html"],
      realPrice: double.parse(e["variants"][0]["compare_at_price"]),
      sellPrice: double.parse(e["variants"][0]["price"]),
      images: (e["images"] as List).map<String>((e) => e["src"]).toList(),
      available: e["status"] == "active",
    );
  }
  factory Product.fromQraphJson(Map e) {
    return Product(
      id: int.parse(e["node"]["id"].toString().split("/").last),
      brande: e["node"]["vendor"] ?? '',
      name: e["node"]["title"] ?? "",
      description: e["node"]["descriptionHtml"] ?? "",
      realPrice: double.tryParse(
        e["node"]["variants"]["edges"][0]["node"]["compareAtPrice"] ?? "",
      ),
      sellPrice: double.tryParse(
          e["node"]["variants"]["edges"][0]["node"]["price"] ?? ''),
      images: (e["node"]["images"]["edges"] as List).map<String>(
        (elem) {
          return elem["node"]["originalSrc"].toString().replaceAll(r"\", "");
        },
      ).toList(),
      available: e["node"]["status"].toString().toLowerCase() == "active",
    );
  }
}
