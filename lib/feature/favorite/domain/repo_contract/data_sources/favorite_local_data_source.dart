import '../../../../../core/entities/product_entity.dart';

abstract class FavoriteLocalDataSource {
  void toggleFavorite(int productId);

  List<ProductEntity> getFavoriteProducts();
}
