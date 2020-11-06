part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartEventInit extends CartEvent {}

class CartEventAddProduct extends CartEvent {
  final String variantId;
  final BuildContext context;

  CartEventAddProduct(this.variantId, this.context);
}

class CartEventRemoveProduct extends CartEvent {
  final String variantId;

  CartEventRemoveProduct(this.variantId);
}

class CartEventChangeCount extends CartEvent {
  final String variantId;
  final int count;

  CartEventChangeCount(this.variantId, this.count);
}

class CartEventSetDiscount extends CartEvent {
  final String discountCode;

  CartEventSetDiscount(this.discountCode);
}

class CartEventProceed extends CartEvent {
  final ShopifyUser user;

  CartEventProceed(this.user);
}
