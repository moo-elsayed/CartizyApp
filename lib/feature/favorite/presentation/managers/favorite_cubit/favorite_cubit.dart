import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/favorite/domain/use_cases/get_favorites_use_case.dart';
import 'package:cartizy_app_nti/feature/favorite/domain/use_cases/toggle_favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._getFavoritesUseCase, this._toggleFavoriteUseCase)
    : super(FavoriteInitial());
  final GetFavoritesUseCase _getFavoritesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  List<ProductEntity> favorites = [];

  void getFavorites() {
    emit(GetFavoritesLoading());
    final favorites = _getFavoritesUseCase.call();
    this.favorites = favorites;
    emit(GetFavoritesSuccess());
  }

  void toggleFavorite(int productId) {
    _toggleFavoriteUseCase.call(productId);
    favorites.removeWhere((product) => product.id == productId);
    emit(ToggleFavorite());
    // getFavorites();
  }
}
