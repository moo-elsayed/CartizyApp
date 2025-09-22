import '../../../../../core/entities/product_entity.dart';

abstract class FavoriteRepo {
  void toggleFavorite(int productId);

  List<ProductEntity> getFavoriteProducts();
}
