import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/get_all_categories_use_case.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/home_toggle_favorite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/network_response.dart';
import '../../../domain/entities/category_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getAllCategoriesUseCase,
    this._getProductsByCategoryUseCase,
    this._homeToggleFavoriteUseCase,
  ) : super(HomeInitial());

  final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final HomeToggleFavoriteUseCase _homeToggleFavoriteUseCase;
  Map<int, List<ProductEntity>> categoryProducts = {};
  List<int> categoriesIds = [];

  Future<void> getAllCategories() async {
    emit(GetAllCategoriesLoading());
    final result = await _getAllCategoriesUseCase.call();
    switch (result) {
      case NetworkSuccess<List<CategoryEntity>>():
        categoriesIds.addAll(result.data?.map((e) => e.id) ?? []);
        emit(GetAllCategoriesSuccess(result.data ?? []));
      case NetworkFailure<List<CategoryEntity>>():
        emit(GetAllCategoriesFailure(result.exception.toString()));
    }
  }

  Future<void> getProductsByCategory(int categoryId) async {
    emit(GetProductsByCategoryLoading());
    final result = await _getProductsByCategoryUseCase.call(categoryId);
    switch (result) {
      case NetworkSuccess<List<ProductEntity>>():
        categoryProducts[categoryId] = result.data ?? [];
        emit(GetProductsByCategorySuccess(categoryProducts[categoryId] ?? []));
      case NetworkFailure<List<ProductEntity>>():
        emit(GetProductsByCategoryFailure(result.exception.toString()));
    }
  }

  void toggleFavoriteProduct(int productId) {
    _homeToggleFavoriteUseCase.call(productId);
  }

  void clear() {
    categoryProducts.clear();
    categoriesIds.clear();
    emit(HomeInitial());
  }
}
