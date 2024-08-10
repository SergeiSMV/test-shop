

import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/products_data.dart';
import '../../domain/hive_repository.dart';

class HiveImplements extends HiveRepository{

  final Box hive = Hive.box('mainStorage');
  
  @override
  Future<void> initProductBase() async {
    List products = await hive.get('products', defaultValue: []);
    products.isEmpty ? await hive.put('products', productsData) : null;
  }

  @override
  Future<void> saveUserData(String name, int id) async {
    await hive.put('user', {'id': id, 'name': name});
  }

  @override
  Future<Map> getUserData() async {
    Map userData = await hive.get('user', defaultValue: {});
    return userData;
  }

  
  @override
  Future<List<Map<String, dynamic>>> getProducts() async {
    final List products = await hive.get('products', defaultValue: []);
    return products.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> searchProducts(String text) async {
    final List<Map<String, dynamic>> products = (await hive.get('products', defaultValue: []))
    .map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item))
    .toList();
    final List<Map<String, dynamic>> filteredProducts = products.where((product) {
      final name = product['name'] as String;
      return name.toLowerCase().contains(text.toLowerCase());
    }).toList();
    return filteredProducts;
  }

  @override
  Future<List> getFavoriteProductsID() async {
    Map userData = await getUserData();
    int userID = userData['id'];
    final List favoriteProducts = await hive.get('favorite$userID', defaultValue: []);
    return favoriteProducts;
  }

  @override
  Future<List> getFavoriteProducts() async {
    List favoriteID = await getFavoriteProductsID();
    final List<Map<String, dynamic>> products = (await hive.get('products', defaultValue: []))
    .map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item))
    .toList();
    List<Map<String, dynamic>> favoriteProducts = products
    .where((product) => favoriteID.contains(product['id']))
    .toList();
    return favoriteProducts;
  }

  @override
  Future<void> addFavoriteProduct(int productID) async {
    Map userData = await getUserData();
    int userID = userData['id'];
    final List favoriteProducts = await hive.get('favorite$userID', defaultValue: []);
    if (!favoriteProducts.contains(productID)) {
      favoriteProducts.add(productID);
    }
    await hive.put('favorite$userID', favoriteProducts);
  }

  @override
  Future<void> removeFavoriteProduct(int productID) async {
    Map userData = await getUserData();
    int userID = userData['id'];
    final List favoriteProducts = await hive.get('favorite$userID', defaultValue: []);
    favoriteProducts.remove(productID);
    await hive.put('favorite$userID', favoriteProducts);
  }

}