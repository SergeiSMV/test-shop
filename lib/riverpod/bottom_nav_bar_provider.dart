
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedNavbarIndexProvider = StateNotifierProvider<SelectedNavbarIndexNotifier, int>((ref) {
  return SelectedNavbarIndexNotifier();
});

class SelectedNavbarIndexNotifier extends StateNotifier<int> {
  SelectedNavbarIndexNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

}


final visibleNavbarProvider = StateNotifierProvider<VisibleNavbarNotifier, bool>((ref) {
  return VisibleNavbarNotifier();
});

class VisibleNavbarNotifier extends StateNotifier<bool> {
  VisibleNavbarNotifier() : super(false);

  void toogle() {
    state = !state;
  }

}