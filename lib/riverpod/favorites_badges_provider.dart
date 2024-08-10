
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesBadgesProvider = StateNotifierProvider<FavoritesBadgesNotifier, int>((ref) {
  return FavoritesBadgesNotifier();
});

class FavoritesBadgesNotifier extends StateNotifier<int> {
  FavoritesBadgesNotifier() : super(0);

  void setCount(int index) {
    state = index;
  }

}