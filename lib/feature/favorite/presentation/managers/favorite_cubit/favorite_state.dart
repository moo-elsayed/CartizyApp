part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class GetFavoritesLoading extends FavoriteState {}

final class GetFavoritesSuccess extends FavoriteState {
  // GetFavoritesSuccess(this.favorites);
  //
  // final List<ProductEntity> favorites;
}

final class GetFavoritesFailure extends FavoriteState {
  GetFavoritesFailure(this.error);

  final String error;
}

final class ToggleFavorite extends FavoriteState {}
