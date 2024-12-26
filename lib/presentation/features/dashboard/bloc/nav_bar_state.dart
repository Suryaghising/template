part of 'nav_bar_cubit.dart';

class NavBarState {
  final int selectedIndex;

  NavBarState({required this.selectedIndex});

  NavBarState copyWith({int? selectedIndex}) {
    return NavBarState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
