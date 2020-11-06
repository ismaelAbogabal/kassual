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

  static Future<List<Product>> collectionProducts(
    String collectionId,
    String cursor, [
    int limit = 200,
  ]) async {
    return ShopifyStore.instance.getXProductsAfterCursorWithinCollection(
      collectionId,
      limit,
      cursor,
    );
  }

  static Future<List<Product>> productsWithFilter(
    Filter filter, {
    String lastCursor,
    Function(String) lastCursorSetter,
  }) async {
    var products;

    if (filter.collectionId != null) {
      products = await ShopifyStore.instance.getAllProductsFromCollectionById(
        filter.collectionId,
      );
    } else {
      products = await ShopifyStore.instance.getAllProductsOnQuery(
        "",
        ("title: *" + filter.title ?? "" + "*").replaceAll("**", ""),
        sortKey: SortKeyProduct.BEST_SELLING,
      );
    }

    return products.where((element) {
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
  }

  static Future<List<Product>> recommendationProducts(String productId) async {
    return ShopifyStore.instance.getProductRecommendations(productId);
  }
}
