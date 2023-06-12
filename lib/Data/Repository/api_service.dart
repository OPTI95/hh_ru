import 'package:dio/dio.dart';
import 'package:hh_ru/Data/Models/category_model.dart';
import 'package:hh_ru/Data/Models/food_model.dart';
import 'package:retrofit/http.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: "https://run.mocky.io/v3/")
abstract class ApiService{
  factory ApiService(Dio dio) = _ApiService;
  @GET('058729bd-1402-4578-88de-265481fd7d54')
  Future<List<CategoryModel>> getCategories();
   @GET('aba7ecaa-0a70-453b-b62d-0e326c859b3b')
  Future<List<FoodModel>> getFoods();
}