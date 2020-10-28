part of 'home_screen_bloc.dart';

@immutable
class HomeScreenState {
  final int index;
  final List<Collection> collections;
  HomeScreenState(this.index, this.collections);
}
