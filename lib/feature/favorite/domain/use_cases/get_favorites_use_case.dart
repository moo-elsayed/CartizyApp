import 'package:cartizy_app_nti/feature/favorite/domain/repo_contract/repo/favorite_repo.dart';
import '../../../../core/entities/product_entity.dart';

class GetFavoritesUseCase {
  GetFavoritesUseCase(this._favoriteRepo);

  final FavoriteRepo _favoriteRepo;

  List<ProductEntity> call() => _favoriteRepo.getFavoriteProducts();
}
