import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/favorite/data/hive/favorite_hive.dart';
import 'package:cartizy_app_nti/feature/favorite/domain/repo_contract/data_sources/favorite_local_data_source.dart';

class FavoriteLocalDataSourceImp implements FavoriteLocalDataSource {
  FavoriteLocalDataSourceImp(this._favoriteHive);

  final FavoriteHive _favoriteHive;

  @override
  List<ProductEntity> getFavoriteProducts() =>
      _favoriteHive.getFavoriteProducts();

  @override
  void toggleFavorite(int productId) =>
      _favoriteHive.toggleFavorite(productId);
}
