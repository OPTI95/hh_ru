part of 'category_screen_cubit.dart';

@immutable
abstract class CategoryScreenState {}

class CategoryScreenInitial extends CategoryScreenState {}
class CategoryScreenLoading extends CategoryScreenState {}
class CategoryScreenLoaded extends CategoryScreenState {
  final List<CategoryModel> list;

  CategoryScreenLoaded({required this.list});
}


