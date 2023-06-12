import 'food_model.dart';

class FoodCartModel extends FoodModel {
  int count;

  FoodCartModel(
      {required super.id,
      required super.name,
      required super.price,
      required super.weight,
      required super.description,
      // ignore: non_constant_identifier_names
      required super.image_url,
      required super.tegs,
      required this.count});
}
