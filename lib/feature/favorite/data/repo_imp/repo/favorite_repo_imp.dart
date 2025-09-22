import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/favorite/domain/repo_contract/data_sources/favorite_local_data_source.dart';
import 'package:cartizy_app_nti/feature/favorite/domain/repo_contract/repo/favorite_repo.dart';

class FavoriteRepoImp implements FavoriteRepo {
  FavoriteRepoImp(this._favoriteLocalDataSource);

  final FavoriteLocalDataSource _favoriteLocalDataSource;

  @override
  List<ProductEntity> getFavoriteProducts() =>
      _favoriteLocalDataSource.getFavoriteProducts();

  @override
  void toggleFavorite(int productId) =>
      _favoriteLocalDataSource.toggleFavorite(productId);
}
