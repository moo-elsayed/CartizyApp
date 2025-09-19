part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetAllCategoriesLoading extends HomeState {}

final class GetAllCategoriesSuccess extends HomeState {
  GetAllCategoriesSuccess(this.categories);

  final List<CategoryEntity> categories;
}

final class GetAllCategoriesFailure extends HomeState {
  GetAllCategoriesFailure(this.error);

  final String error;
}

final class GetProductsByCategoryLoading extends HomeState {}

final class GetProductsByCategorySuccess extends HomeState {
  GetProductsByCategorySuccess(this.products);

  final List<ProductEntity> products;
}

final class GetProductsByCategoryFailure extends HomeState {
  GetProductsByCategoryFailure(this.error);

  final String error;
}
