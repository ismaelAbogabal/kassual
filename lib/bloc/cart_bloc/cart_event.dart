part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartEventInit extends CartEvent {
  final ShopifyUser user;

  CartEventInit(this.user);
}

class CartEventAddProduct extends CartEvent {
  final Product product;

  CartEventAddProduct(this.product);
}

class CartEventRemoveProduct extends CartEvent {
  final Product product;

  CartEventRemoveProduct(this.product);
}

class CartEventChangeCount extends CartEvent {
  final Product product;
  final int count;

  CartEventChangeCount(this.product, this.count);
}

class CartEventSetDiscount extends CartEvent {
  final String discountCode;

  CartEventSetDiscount(this.discountCode);
}
