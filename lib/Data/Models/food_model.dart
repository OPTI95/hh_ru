import 'package:json_annotation/json_annotation.dart';
part 'food_model.g.dart';
@JsonSerializable()
class FoodModel {
  final int id;
  final String name;
  final int price;
  final int weight;
  final String description;
  // ignore: non_constant_identifier_names
  final String image_url;
  final List<String> tegs;
  FoodModel({required this.id, required this.name,required this.price, required this.weight, required this.description, required this.image_url, required this.tegs, });
  factory FoodModel.fromJson(Map<String, dynamic> json) => _$FoodModelFromJson(json);
  Map<String, dynamic> toJson() => _$FoodModelToJson(this);
}