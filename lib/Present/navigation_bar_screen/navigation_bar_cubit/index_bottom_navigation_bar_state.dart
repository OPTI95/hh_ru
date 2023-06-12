part of 'index_bottom_navigation_bar_cubit.dart';

@immutable
abstract class IndexBottomNavigationBarState {}

class IndexBottomNavigationBarInitial extends IndexBottomNavigationBarState {
  final int index;
  final bool show;

  IndexBottomNavigationBarInitial({
    required this.index,
    this.show = false,
  });

  IndexBottomNavigationBarInitial copyWith({
    int? index,
    bool? show,
  }) {
    return IndexBottomNavigationBarInitial(
      index: index ?? this.index,
      show: show ?? this.show,
    );
  }
}
