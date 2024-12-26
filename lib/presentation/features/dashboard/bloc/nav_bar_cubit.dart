import 'package:bloc/bloc.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarState(selectedIndex: 0));

  void changeIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
