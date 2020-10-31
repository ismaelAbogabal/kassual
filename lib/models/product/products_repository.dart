import 'package:flutter_simple_shopify/enums/src/sort_key_collection.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:flutter_simple_shopify/models/src/product.dart';
import 'package:kassual/models/product/filter.dart';

class ProductRepository {
  static Future<List<Collection>> getAllCollections() async {
     var categories =
        await ShopifyStore.instance.getXCollectionsAndNProductsSorted(
      7,
      13,
      sortKeyCollection: SortKeyCollection.RELEVANCE,
    );

    categories.removeWhere((element) => element.products.productList.isEmpty);

    return categories;
  }

  static Future<List<Product>> collectionProducts(String collectionId) async {
    return ShopifyStore.instance.getAllProductsFromCollectionById(collectionId);
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
}
