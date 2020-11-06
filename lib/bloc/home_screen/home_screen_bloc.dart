import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/models/product/products_repository.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenSetScreen, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState(0, null)) {
    init();
  }

  init() {
    ProductRepository.getCard().then((value) {
      emit(HomeScreenState(state.index, value));
    }).catchError((e) {
      init();
    });
  }

  factory HomeScreenBloc.of(BuildContext context) =>
      BlocProvider.of<HomeScreenBloc>(context);

  @override
  Stream<HomeScreenState> mapEventToState(
    HomeScreenSetScreen event,
  ) async* {
    yield HomeScreenState(event.index, state.card);
  }
}
