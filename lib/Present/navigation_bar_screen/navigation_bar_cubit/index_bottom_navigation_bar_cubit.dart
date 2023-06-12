import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'index_bottom_navigation_bar_state.dart';

class IndexBottomNavigationBarCubit
    extends Cubit<IndexBottomNavigationBarState> {
  IndexBottomNavigationBarCubit()
      : super(IndexBottomNavigationBarInitial(index: 0));
  bool showBottomSheetMoreInfoFood = false;
  int currentIndexCategory = 0;

  void setIndex(int index) {
    IndexBottomNavigationBarInitial cstate =
        state as IndexBottomNavigationBarInitial;
    emit(cstate.copyWith(index: index));
  }

  void setShowBool(bool show) {
    IndexBottomNavigationBarInitial currentState =
        state as IndexBottomNavigationBarInitial;
    emit(currentState.copyWith(show: show));
  }
}
