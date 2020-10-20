import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String brande;
  final String description;
  final double realPrice;
  final double sellPrice;
  final bool available;
  final List<String> images;
  final Map attributes;
  final int lengthWidth;
  final int lengthHeight;
  final int bridge;
  final int temple;

  Product({
    @required this.id,
    @required this.name,
    @required this.brande,
    @required this.realPrice,
    @required this.sellPrice,
    @required this.images,
    @required this.available,
    this.description =
        "Valentino 4055 Sunglasses, the perfect daily shades. Featuring an elegant Butterfly frame shape made of acetate with crystal studs and the brand’s classic logo on the temples. Lightness, grace and precious delicacy are the DNA of Valentino. The Valentino eyewear collections embodies the Maison’s timeless elegance in a perfect balance between tradition and innovation in full respect of the iconic values of the brand. Showcasing Grey Gradient lenses that provide 100% UV protection, these designer sunglasses ship with a Valentino box, travel case, cleaning cloth pouch and authenticity documentation.",
    this.attributes = const {},
    this.bridge = 20,
    this.lengthHeight = 40,
    this.lengthWidth = 40,
    this.temple = 90,
  });

  String get image => images.first;
}
