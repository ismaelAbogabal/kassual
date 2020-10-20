import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenSetIndex, HomeScreenLoaded> {
  HomeScreenBloc() : super(HomeScreenLoaded(0));

  factory HomeScreenBloc.of(BuildContext context) =>
      BlocProvider.of<HomeScreenBloc>(context);

  @override
  Stream<HomeScreenLoaded> mapEventToState(
    HomeScreenSetIndex event,
  ) async* {
    yield HomeScreenLoaded(event.index);
  }
}
