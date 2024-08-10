



abstract class HiveRepository {

  Future<void> initProductBase();

  Future<void> saveUserData(String name, int id);

  Future<Map> getUserData();

  Future<List> getProducts();

  Future<List<Map<String, dynamic>>> searchProducts(String text);

  Future<List> getFavoriteProductsID();

  Future<List> getFavoriteProducts();

  Future<void> addFavoriteProduct(int productID);

  Future<void> removeFavoriteProduct(int productID);

}