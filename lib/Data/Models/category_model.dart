import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';
@JsonSerializable()
class CategoryModel {
  final int id;
  final String name;
  // ignore: non_constant_identifier_names
  final String image_url;
  CategoryModel({required this.id, required this.name, required this.image_url});
  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
