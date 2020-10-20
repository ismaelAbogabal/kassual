import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kassual/models/cart/cart.dart';
import 'package:kassual/models/cart/cart_repository.dart';
import 'package:kassual/models/product/product.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  //todo fetch the cart when open the app
  CartBloc() : super(CartStateLoaded(Cart(products: {})));

  factory CartBloc.of(BuildContext context) =>
      BlocProvider.of<CartBloc>(context);

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    print("Cart Event ${event.runtimeType}");
    if (state is CartStateLoading) return;
    if (event is CartEventAddProduct) {
      CartRepository repository =
          CartRepository((state as CartStateLoaded).cart);

      yield CartStateLoaded(await repository.addProduct(event.product));
    } else if (event is CartEventRemoveProduct) {
      CartRepository repository =
          CartRepository((state as CartStateLoaded).cart);

      yield CartStateLoaded(await repository.removeProduct(event.product));
    } else if (event is CartEventSetDiscount) {
      CartRepository repository =
          CartRepository((state as CartStateLoaded).cart);

      yield CartStateLoaded(await repository.addDiscount(event.discountCode));
    } else if (event is CartEventChangeCount) {
      CartRepository repository =
          CartRepository((state as CartStateLoaded).cart);

      yield CartStateLoaded(
          await repository.changeCount(event.product, event.count));
    }
  }
}
