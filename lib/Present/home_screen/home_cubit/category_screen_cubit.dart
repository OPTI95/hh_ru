import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hh_ru/Data/Models/category_model.dart';
import 'package:hh_ru/Data/Repository/api_service.dart';
import 'package:meta/meta.dart';

part 'category_screen_state.dart';

class CategoryScreenCubit extends Cubit<CategoryScreenState> {
  CategoryScreenCubit() : super(CategoryScreenInitial());
  Future<void> getListCategories() async {
    emit(CategoryScreenLoading());
    final apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    emit(CategoryScreenLoaded(list: await apiService.getCategories()));
  }
}
