part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class USLoading extends UserState {
  @override
  List<Object> get props => [];
}

class USEmpty extends UserState {
  final String error;

  USEmpty([this.error]);

  @override
  List<Object> get props => [error];
}

class USLoaded extends UserState {
  final ShopifyUser user;

  USLoaded(this.user);

  @override
  List<Object> get props => [user];
}
