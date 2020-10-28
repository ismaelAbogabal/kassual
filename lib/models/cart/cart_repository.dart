import 'package:flutter_simple_shopify/flutter_simple_shopify.dart'
    hide Product;

import 'package:kassual/models/product/product.dart';

class CartRepository {
  final Checkout checkout;

  CartRepository(this.checkout);

  static Future<Checkout> init(ShopifyUser user, [String id]) async {
    id ??= user.lastIncompleteCheckout?.id;
    if (id == null) {
      id = await ShopifyCheckout.instance.createCheckout();
    }

    return ShopifyCheckout.instance
        .getCheckoutInfoQuery(id, deleteThisPartOfCache: true);
  }

  Future<Checkout> addProduct(Product product) async {
    ShopifyCheckout.instance.checkoutLineItemsReplace(
      checkout.id,
      checkout.lineItems.lineItemList.map((e) => e.variant.id).toList(),
      deleteThisPartOfCache: true,
    );

    return init(null, checkout.id);
  }

  Future<Checkout> removeProduct(Product product) async {
    return checkout;
  }

  Future<Checkout> addDiscount(String discount) async {
    //todo add discount
    return checkout;
  }

  Future<Checkout> changeCount(Product product, int count) async {
    return checkout;
  }
}
