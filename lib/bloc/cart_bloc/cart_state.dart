part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartStateLoading extends CartState {}

class CartStateLoaded extends CartState {
  final Cart cart;

  CartStateLoaded(this.cart);
}
