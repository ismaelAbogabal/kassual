import 'package:kassual/models/product/product.dart';

import 'cart.dart';

class CartRepository {
  final Cart cart;

  const CartRepository(this.cart);

  Future<Cart> addProduct(Product product) async {
    int val = cart.products[product] ?? 0;
    cart.products[product] = val + 1;
    return cart;
  }

  Future<Cart> removeProduct(Product product) async {
    cart.products.remove(product);
    return cart;
  }

  Future<Cart> addDiscount(String discountCode) async {
    return Cart(
      discountCode: discountCode,
      products: cart.products,
    );
  }

  Future<Cart> changeCount(Product product, int count) async {
    if (cart.products[product] != null) {
      cart.products[product] = count;
    }
    return cart;
  }
}
