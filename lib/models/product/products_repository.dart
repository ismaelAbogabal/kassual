import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:flutter_simple_shopify/models/src/product.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kassual/models/product/filter.dart';
import 'package:kassual/models/product/get_collections_query.dart';

class ProductRepository {
  static Future<List<Collection>> getAllCollections() async {
    List<Collection> collectionList;
    WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(getAllCollectionQuery),
    );

    final QueryResult result =
        await ShopifyConfig.graphQLClient.query(_options);

    if (result.hasException) throw Exception(result.exception.toString());

    collectionList = (Collections.fromJson(
      (result?.data ?? const {})['collections'] ?? {},
    )).collectionList;

    collectionList
        .removeWhere((element) => element.products.productList.isEmpty);
    return collectionList;
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
}
