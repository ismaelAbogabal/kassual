import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:flutter_simple_shopify/models/src/product.dart';
import 'package:kassual/models/product/filter.dart';

class ProductRepository {
  static Future<Product> getCard() async {
    var products = await ShopifyStore.instance.getProductsByIds([
      r"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzQ5MzM1MjE4MDEzNTY=",
    ]);

    return products.first;
  }

  // static Future<List<Product>> collectionProducts(
  //   String collectionId,
  //   String cursor, [
  //   int limit = 200,
  // ]) async {
  //   return ShopifyStore.instance.getXProductsAfterCursorWithinCollection(
  //     collectionId,
  //     limit,
  //     cursor,
  //   );
  // }

  static Future<List<Product>> productsWithFilter(
    Filter filter, {
    int limit = 50,
    String lastCursor,
    Function(String) lastCursorSetter,
  }) async {
    List<Product> products;

    if (filter.collectionId != null) {
      products =
          await ShopifyStore.instance.getXProductsAfterCursorWithinCollection(
        filter.collectionId,
        limit,
        lastCursor,
      );
    } else {
      String query = ("title:*" +
              (filter.title ?? "") +
              "* vendor:" +
              (filter.brande?.isNotEmpty == true ? filter.brande : "*"))
          .replaceAll("**", "*");

      products = await ShopifyStore.instance.getXProductsOnQueryAfterCursor(
        query,
        limit,
        lastCursor,
        sortKey: SortKeyProduct.RELEVANCE,
      );
    }
    try {
      lastCursorSetter(products.last.cursor);
    } catch (e) {}

    var _list = products.where((element) {
      if (filter.minimumPrice != null &&
          filter.minimumPrice > element.productVariants.first.price.amount) {
        return false;
      }
      if (filter.maximumPrice != null &&
          filter.maximumPrice < element.productVariants.first.price.amount) {
        return false;
      }

      return true;
    }).toList();

    if (_list.isEmpty && products.isNotEmpty) {
      return productsWithFilter(
        Filter(
          title: filter.title,
          maximumPrice: filter.maximumPrice,
          minimumPrice: filter.minimumPrice,
          brande: filter.brande,
          collectionId: filter.collectionId,
        ),
        lastCursor: products.last.cursor,
        lastCursorSetter: lastCursorSetter,
        limit: limit,
      );
    }

    return _list;
  }

  static Future<List<Product>> recommendationProducts(String productId) async {
    return ShopifyStore.instance.getProductRecommendations(productId);
  }
}
