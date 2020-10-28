part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UEInit extends UserEvent {}

class UERemoveError extends UserEvent {}

class UELogin extends UserEvent {
  final String email;
  final String password;

  UELogin(this.email, this.password);
}

class UESignIn extends UserEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UESignIn({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
  });
}

class UESignOut extends UserEvent {}

class UEAddAddress extends UserEvent {
  final Address address;

  UEAddAddress(this.address);
}

class UEModifyAddress extends UserEvent {
  final Address address;

  UEModifyAddress(this.address);
}

class UERemoveAddress extends UserEvent {
  final Address address;

  UERemoveAddress(this.address);
}
