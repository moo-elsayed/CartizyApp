import '../repo_contract/repo/favorite_repo.dart';

class ToggleFavoriteUseCase {
  ToggleFavoriteUseCase(this._favoriteRepo);

  final FavoriteRepo _favoriteRepo;

  void call(int productId) =>
      _favoriteRepo.toggleFavorite(productId);
}
