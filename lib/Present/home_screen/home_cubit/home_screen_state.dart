part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}
class HomeScreenCityLoadingState extends HomeScreenState {}
class HomeScreenCityLoadedState extends HomeScreenState {
  final String nameSity;

  HomeScreenCityLoadedState(this.nameSity);
}

