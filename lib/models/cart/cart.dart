import 'package:kassual/models/product/product.dart';

class Cart {
  final Map<Product, int> products;
  final String discountCode;
  final double discountedPrice;

  Cart({this.products, this.discountCode, this.discountedPrice});

  double get totalPrice => products.entries.fold(
        0.0,
        (previousValue, element) =>
            previousValue + element.value * element.key.sellPrice,
      );
}
