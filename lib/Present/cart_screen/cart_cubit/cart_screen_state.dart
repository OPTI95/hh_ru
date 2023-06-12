part of 'cart_screen_cubit.dart';

@immutable
abstract class CartScreenState {}

class CartScreenInitial extends CartScreenState {}
class CartScreenLoadingState extends CartScreenState {}
class CartScreenLoadedState extends CartScreenState {
  final List<FoodCartModel> list;

  CartScreenLoadedState(this.list);
}
