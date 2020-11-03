import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final Checkout checkout;

  CartRepository(this.checkout);

  static Future<Checkout> init([String id]) async {
    id ??= await SharedPreferences.getInstance().then(
      (value) => value.getString("checkout_id"),
    );

    if (id == null || id.isEmpty) {
      String id = await ShopifyCheckout.instance.createCheckout();
      SharedPreferences.getInstance().then(
        (value) => value.setString("checkout_id", id),
      );
    }

    try {
      var accessToken = await ShopifyAuth.currentCustomerAccessToken;
      if (accessToken != null) await _setUpCheckoutWithUser(id, accessToken);
    } catch (e) {}

    var checkout = await ShopifyCheckout.instance.getCheckoutInfoQuery(
      id,
      deleteThisPartOfCache: true,
    );
    return checkout;
  }

  // static Future<Checkout> init(ShopifyUser user, [String id]) async {
  //   id ??= user?.lastIncompleteCheckout?.id;
  //
  //   if (id == null) {
  //     id = await ShopifyCheckout.instance.createCheckout();
  //   }
  //
  //   await ShopifyCheckout.instance.checkoutCustomerAssociate(
  //     id,
  //     await ShopifyAuth.currentCustomerAccessToken,
  //   );
  //
  //   return ShopifyCheckout.instance
  //       .getCheckoutInfoQuery(id, deleteThisPartOfCache: true);
  // }

  static Future _setUpCheckoutWithUser(
    String checkoutId,
    String userAccessToken,
  ) async {
    await ShopifyCheckout.instance.checkoutCustomerAssociate(
      checkoutId,
      userAccessToken,
    );
  }

  Future<Checkout> addProduct(String variantId) async {
    List<String> variantList = [];
    for (var value in checkout.lineItems.lineItemList) {
      for (int i = 0; i < value.quantity; i++) {
        variantList.add(value.variant.id);
      }
    }
    variantList.add(variantId);

    await ShopifyCheckout.instance.checkoutLineItemsReplace(
      checkout.id,
      variantList,
      deleteThisPartOfCache: true,
    );
    return await init(checkout.id);
  }

  Future<Checkout> removeProduct(String variantId) async {
    return changeCount(variantId, 0);
  }

  Future<Checkout> addDiscount(String discount) async {
    return checkout;
  }

  Future<Checkout> changeCount(String variant, int count) async {
    List<String> variantList = [];
    for (var value in checkout.lineItems.lineItemList) {
      if (value.variant.id == variant) {
        for (int i = 0; i < count; i++) {
          variantList.add(variant);
        }
      } else {
        for (int i = 0; i < value.quantity; i++) {
          variantList.add(value.variant.id);
        }
      }
    }
    await ShopifyCheckout.instance.checkoutLineItemsReplace(
      checkout.id,
      variantList,
      deleteThisPartOfCache: true,
    );

    return init(checkout.id);
  }

  static Future<List<Order>> allOrders() async {
    try {
      String accessToken = await ShopifyAuth.currentCustomerAccessToken;
      return ShopifyCheckout.instance.getAllOrders(accessToken);
    } catch (e) {}
  }
}
