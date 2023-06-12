import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hh_ru/Data/Models/food_model.dart';
import 'package:meta/meta.dart';

import '../../../Data/Repository/api_service.dart';
part 'food_screen_state.dart';

class FoodScreenCubit extends Cubit<FoodScreenState> {
  FoodScreenCubit() : super(FoodScreenInitial());
  late List<FoodModel> originalListFood;
  bool checkChip = false;
  Future<void> getListFoods() async {
    emit(FoodScreenLoadingState());
    final apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    originalListFood = await apiService.getFoods();
    List<String> tegs = [];
    originalListFood.forEach(
      (element) {
        tegs.addAll(element.tegs);
      },
    );
    tegs = tegs.toSet().toList();
    tegs.sort();
    emit(FoodScreenLoadedState(
        foodList: originalListFood, tegsList: tegs));
  }

  Future<void> getListFoodsWhereTegs(int num) async {
    checkChip = true;
    List<FoodModel> list =
        originalListFood.where((element) {
      return element.tegs
          .contains((state as FoodScreenLoadedState).tegsList[num]);
    }).toList();

    List<String> tegs = [];
    originalListFood.forEach(
      (element) {
        tegs.addAll(element.tegs);
      },
    );
    tegs = tegs.toSet().toList();
    tegs.sort();
    emit(FoodScreenLoadedState(foodList: list, tegsList: tegs));
  }
}
