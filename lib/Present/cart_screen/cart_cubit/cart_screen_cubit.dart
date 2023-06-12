import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../Data/Models/foodCart_model.dart';
import '../../../Data/Models/food_model.dart';
import 'package:meta/meta.dart';

part 'cart_screen_state.dart';

class CartScreenCubit extends Cubit<CartScreenState> {
  CartScreenCubit() : super(CartScreenInitial());
  List<FoodCartModel> listCart = [];
  int price = 0;
  Future<void> getListCartFood() async {
    emit(CartScreenLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    await getSummaPrice();
    emit(CartScreenLoadedState(listCart));
  }

  Future<void> addFoodInCart(FoodModel foodModel) async {
    FoodCartModel foodCartModel = FoodCartModel(
        id: foodModel.id,
        name: foodModel.name,
        price: foodModel.price,
        weight: foodModel.weight,
        description: foodModel.description,
        image_url: foodModel.image_url,
        tegs: foodModel.tegs,
        count: 1);
    try {
      FoodCartModel? existingCartModel = listCart.firstWhere(
        (item) => item.id == foodCartModel.id,
      );
      existingCartModel.count += 1;
    } catch (e) {
      foodCartModel.count = 1;
      listCart.add(foodCartModel);
    }
    await getSummaPrice();
  }

  Future<void> getSummaPrice() async {
    price = 0;
    for (var item in listCart) {
      price += item.price * item.count;
    }
  }

  Future<void> removeCountFoodInCart(FoodCartModel foodCartModel) async {
    try {
      FoodCartModel? existingCartModel = listCart.firstWhere(
        (item) => item.id == foodCartModel.id,
      );

      if (existingCartModel.count > 1) {
        existingCartModel.count -= 1;
      } else {
        listCart.remove(foodCartModel);
      }
    } catch (e) {}
    await getSummaPrice();
  }

  Future<void> addCountFoodInCart(FoodCartModel foodCartModel) async {
    try {
      FoodCartModel? existingCartModel = listCart.firstWhere(
        (item) => item.id == foodCartModel.id,
      );
      existingCartModel.count += 1;
    } catch (e) {}
    await getSummaPrice();
  }
}
