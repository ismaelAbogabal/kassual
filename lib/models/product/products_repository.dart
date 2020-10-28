import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:kassual/models/api/api.dart';
import 'package:kassual/models/product/filter.dart';
import 'package:kassual/models/product/product.dart';

import 'package:http/http.dart' as http;
import 'collections.dart';

class ProductRepository {
  static Future<List<Collection>> _getAllCollections([int limit]) async {
    var response = await http.get(Api.collectionApi, headers: {
      "content-type": "Application/json",
    });
    Map body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List collectionsMap = body["smart_collections"] as List;
      List<Collection> collections = [];
      for (var map in collectionsMap.sublist(0, limit)) {
        collections.add(
          Collection.fromJson(map, "", await collectionProducts(map["id"])),
        );
      }
      return collections;
    } else {
      throw Exception("Network error");
    }
  }

  static Future<List<Collection>> getAllCollections([int limit]) async {
    var query = ''' 
    {
      collections(first: 12) {
        edges {
          node {
            id
            title
            products(first: 7) {
              edges {
                node {
                  id
                  title
                  descriptionHtml
                  status
                  images(first :3 ){
                    edges{
                      node{
                        originalSrc
                      }
                    }
                  }
                  variants(first: 1) {
                    edges {
                      node {
                        price
                        availableForSale
                        compareAtPrice
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
   }    ''';

    var response = await http.post(
      Api.graphApi,
      headers: {"content-type": "application/graphql"},
      body: query,
    );

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List collectionsMap = data["data"]["collections"]["edges"];

      return collectionsMap.map((e) => Collection.fromGraph(e)).toList();
    }

    return [];
  }

  static Future<List<Product>> collectionProducts(String collectionId) async {
    //todo enter change id
    var response = await http.post(Api.graphApi,
        headers: {"content-type": "application/graphql"}, body: '''
        {
          collection(id : "$collectionId"){
            products(first : 50) {
              edges{
                node{
                  title
                  id
                  variants(first :1){ edges{node{price  availableForSale compareAtPrice }}}
                  descriptionHtml 
                  status 
                  collections(first : 3 ){ edges{node{ id }}} 
                  images(first : 2 ){edges{node{ originalSrc }}} 
            }
        }}}}
      ''');

    Map data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var products = (data["data"]["collection"]["products"]["edges"] as List)
          .map((e) => Product.fromQraphJson(e))
          .toList();

      return products;
    } else {
      print(response.body);
      throw Exception();
    }
  }

  static Future<Product> product(int id) async {
    var response = await http.get(id);

    if (response.statusCode == 200) {
      Map body = jsonDecode(response.body);
      return Product.fromJson(body["product"]);
    } else {
      throw Exception("Getting product failed");
    }
  }

  static Future<List<Product>> _productsWithFilter(Filter filter) async {
    //   String url = Api.productsApi + "?";
    //
    //   if (filter.title != null) {
    //     url += "title=${filter.title}&";
    //   }
    //   if (filter.collectionId != null) {
    //     url += "collection_id=${filter.collectionId}&";
    //   }
    //   if (filter.brande != null) {
    //     url += "vendor=${filter.brande}";
    //   }
    //   //to remove last char & ?
    //
    //   url = url.substring(0, url.length - 1);
    //   // url = url.replaceAll("2020-10/", "2019-04/");
    //   // url = url.replaceAll("api/", "");
    //   print(url);
    //
    //   var response = await http.get(url);
    //   print(response.body);
    //
    //   if (response.body != null && response.statusCode == 200) {
    //     Map body = jsonDecode(response.body);
    //     return (body["products"] as List)
    //         .map((e) => Product.fromJson(e))
    //         .toList();
    //   }
    //   throw Exception("");

    // ...
  }

  static Future<List<Product>> productsWithFilter(
    Filter filter, {
    String lastCursor,
    Function(String) lastCursorSetter,
  }) async {
    String query =
        '{products (first :60, after:${lastCursor == null ? "null" : "\"$lastCursor\""} , query :"title:*${filter.title ?? ""}* vendor:${filter.brande ?? "*"} "  ){ edges{ cursor node{ title id descriptionHtml status collections(first : 3 ){ edges{node{ id }}} images(first : 5 ){edges{node{ originalSrc }}} variants(first :1){ edges{node{price  availableForSale compareAtPrice } } } } } }  }  '
            .replaceAll("**", "*");
    var response = await http.post(
      Api.graphApi,
      headers: {"content-type": "Application/graphql"},
      body: query,
    );

    if (response.body != null && response.statusCode == 200) {
      Map body = jsonDecode(response.body);
      List products = (body["data"]["products"]["edges"] as List).where(
        (element) {
          return filter.collectionId == null ||
              (element["node"]["collections"]["edges"] as List).any(
                  (element) => element["node"]["id"] == filter.collectionId);
        },
      ).map((e) {
        lastCursor = e["cursor"];
        return Product.fromQraphJson(e);
      }).toList();

      lastCursorSetter?.call(lastCursor);
      return products;
    }
  }
}
