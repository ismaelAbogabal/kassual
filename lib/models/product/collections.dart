import 'package:kassual/models/product/product.dart';

class Collection {
  final String id;
  final String title;
  final String image;
  final List<Product> products;

  Collection(this.id, this.title, this.image, this.products);

  Collection.fromJson(Map json, this.image, this.products)
      : id = json['id'],
        title = json["title"];

  Collection.fromGraph(Map data)
      : id = data["node"]["id"],
        title = data["node"]["title"],
        image = null,
        products = (data["node"]["products"]["edges"] as List)
            .map((e) => Product.fromQraphJson(e))
            .toList();
}
