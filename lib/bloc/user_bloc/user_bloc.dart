import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/models/user/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(USLoading()) {
    add(UEInit());
  }

  factory UserBloc.of(BuildContext context) =>
      BlocProvider.of<UserBloc>(context);

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    print("User event $event");
    if (event is UEInit) {
      yield await _mapInit();
    } else if (event is UERemoveError) {
      yield (state is USEmpty) ? USEmpty() : state;
    } else if (event is UELogin) {
      yield await _mapLogin(event);
    } else if (event is UESignIn) {
      yield await _mapSignUp(event);
    } else if (event is UESignOut) {
      UserRepository.signOut();
      yield USEmpty();
    } else if (event is UERemoveAddress) {
      await _mapRemoveAddress(event.address);
      yield await _mapInit();
    } else if (event is UEAddAddress) {
      await _mapAddAddress(event.address);
      yield await _mapInit();
    } else if (event is UEModifyAddress) {
      await _mapModifyAddress(event.address);
      yield await _mapInit();
    }
  }

  Future<UserState> _mapInit() async {
    try {
      var u = await UserRepository.init();
      return u == null ? USEmpty() : USLoaded(u);
    } on Exception {
      return USEmpty("please enter a valid input");
    }
  }

  Future<UserState> _mapLogin(UELogin event) async {
    try {
      var u = await UserRepository.loginUser(
        email: event.email,
        password: event.password,
      );
      return USLoaded(u);
    } catch (e) {
      return USEmpty("Please enter a valid login data");
    }
  }

  Future<UserState> _mapSignUp(UESignIn event) async {
    try {
      var u = await UserRepository.createUser(
        password: event.password,
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
      );
      return USLoaded(u);
    } on Exception {
      return USEmpty();
    }
  }

  Future<void> _mapRemoveAddress(Address address) {
    return UserRepository.removeAddress(address);
  }

  Future<void> _mapAddAddress(Address address) {
    return UserRepository.addAddress(address);
  }

  Future<void> _mapModifyAddress(Address address) {
    return UserRepository.modifyAddress(address);
  }
}
