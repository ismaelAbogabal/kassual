import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart'
    hide Product;
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/user_bloc/user_bloc.dart';
import 'package:kassual/models/cart/cart_repository.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

///todo when there are no user
///setup cart for no user
///
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(UserBloc userBloc) : super(CartStateLoading()) {
    userBloc.listen((state) {
      add(CartEventInit());
    });
  }

  factory CartBloc.of(BuildContext context) =>
      BlocProvider.of<CartBloc>(context);

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    print(event);
    if (event is CartEventInit) {
      var checkout = await CartRepository.init();
      yield CartStateLoaded(checkout);
    } else if (event is CartEventAddProduct) {
      var s = (state as CartStateLoaded);
      yield CartStateLoading();
      CartRepository repository = CartRepository(s.cart);
      yield CartStateLoaded(await repository.addProduct(event.variantId));
    } else if (event is CartEventRemoveProduct) {
      var s = (state as CartStateLoaded);
      yield CartStateLoading();
      CartRepository repository = CartRepository(s.cart);

      yield CartStateLoaded(await repository.removeProduct(event.variantId));
    } else if (event is CartEventSetDiscount) {
      CartRepository repository =
          CartRepository((state as CartStateLoaded).cart);

      yield CartStateLoaded(await repository.addDiscount(event.discountCode));
    } else if (event is CartEventChangeCount) {
      print(event.count);
      var s = state as CartStateLoaded;
      yield CartStateLoading();
      CartRepository repository = CartRepository(s.cart);

      yield CartStateLoaded(
        await repository.changeCount(
          event.variantId,
          event.count,
        ),
      );
    }
  }
}
