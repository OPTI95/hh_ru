part of 'food_screen_cubit.dart';

@immutable
abstract class FoodScreenState {}

class FoodScreenInitial extends FoodScreenState {}
class FoodScreenLoadingState extends FoodScreenState {}
class FoodScreenLoadedState extends FoodScreenState {
  final List<FoodModel> foodList;
  final List<String> tegsList;
  FoodScreenLoadedState({required this.foodList, required this.tegsList});
}

