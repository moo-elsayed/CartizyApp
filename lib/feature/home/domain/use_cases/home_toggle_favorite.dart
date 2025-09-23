import 'package:cartizy_app_nti/feature/favorite/domain/use_cases/toggle_favorite.dart';

class HomeToggleFavoriteUseCase {
  /// we will use ToggleFavoriteUseCase from favorite feature

  HomeToggleFavoriteUseCase(this._toggleFavoriteUseCase);

  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  void call(int productId) => _toggleFavoriteUseCase.call(productId);
}
