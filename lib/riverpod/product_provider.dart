

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/hive_implements/hive_implements.dart';
import 'favorites_badges_provider.dart';

final productsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);


final baseProductsProvider = FutureProvider.autoDispose((ref) async {
  final HiveImplements hive = HiveImplements(); 
  final List<Map<String, dynamic>> result = await hive.getProducts();
  ref.read(productsProvider.notifier).state = result;
});


final favoriteIdProvider = StateProvider<List>((ref) => []);

final baseFavoriteIdProvider = FutureProvider.autoDispose((ref) async {
  final HiveImplements hive = HiveImplements();
  final List result = await hive.getFavoriteProductsID();
  ref.read(favoritesBadgesProvider.notifier).setCount(result.length);
  ref.read(favoriteIdProvider.notifier).state = result.toList();
  return ref.refresh(baseFavoriteProductsProvider);
});

final favoriteProductsProvider = StateProvider<List>((ref) => []);

final baseFavoriteProductsProvider = FutureProvider.autoDispose((ref) async {
  final HiveImplements hive = HiveImplements();
  final List result = await hive.getFavoriteProducts();
  ref.read(favoriteProductsProvider.notifier).state = result.toList();
});


final searchProductsProvider = StateNotifierProvider<SearchNotifier, List<Map<String, dynamic>>?>((ref) {
  return SearchNotifier();
});


class SearchNotifier extends StateNotifier<List<Map<String, dynamic>>?> {
  SearchNotifier() : super(null);

  Future<void> searchProducts(String text) async {
    final HiveImplements hive = HiveImplements();
    final List<Map<String, dynamic>> result = await hive.searchProducts(text);
    state = result;
  }

  void clearSearch() {
    state = null;
  }
}



