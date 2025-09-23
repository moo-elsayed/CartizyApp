import 'package:cartizy_app_nti/core/helpers/hive_helper.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/data_sources/home_local_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/data_sources/home_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/repo_contract/repo/home_repo.dart';

import '../../../../../core/helpers/shared_preferences_manager.dart';

class HomeRepoImp implements HomeRepo {
  HomeRepoImp(this._homeRemoteDataSourceImp, this._homeLocalDataSourceImp);

  final HomeRemoteDataSourceImp _homeRemoteDataSourceImp;
  final HomeLocalDataSourceImp _homeLocalDataSourceImp;

  @override
  Future<NetworkResponse<List<CategoryEntity>>> getAllCategories() async {
    List<CategoryEntity> categories;
    final lastFetch = await SharedPreferencesManager.getLastFetchTime();
    final isCacheValid =
        lastFetch != null &&
        DateTime.now().difference(lastFetch) < HiveHelper.cacheValidity;
    categories = await _homeLocalDataSourceImp.getAllCategories();
    if (categories.isEmpty || !isCacheValid) {
      final result = await _homeRemoteDataSourceImp.getAllCategories();
      switch (result) {
        case NetworkSuccess<List<CategoryEntity>>():
          categories = result.data ?? [];
          return NetworkSuccess<List<CategoryEntity>>(categories);

        case NetworkFailure<List<CategoryEntity>>():
          return NetworkFailure<List<CategoryEntity>>(result.exception);
      }
    } else {
      return NetworkSuccess<List<CategoryEntity>>(categories);
    }
  }

  @override
  Future<NetworkResponse<List<ProductEntity>>> getProductsByCategory(
    int categoryId,
  ) async {
    final lastFetch = await SharedPreferencesManager.getLastFetchTime();
    final isCacheValid =
        lastFetch != null &&
        DateTime.now().difference(lastFetch) < HiveHelper.cacheValidity;
    List<ProductEntity> products;
    products = await _homeLocalDataSourceImp.getProductsByCategory(categoryId);
    if (products.isEmpty || !isCacheValid) {
      final result = await _homeRemoteDataSourceImp.getProductsByCategory(
        categoryId,
      );
      switch (result) {
        case NetworkSuccess<List<ProductEntity>>():
          products = result.data ?? [];
          return NetworkSuccess<List<ProductEntity>>(products);
        case NetworkFailure<List<ProductEntity>>():
          return NetworkFailure<List<ProductEntity>>(result.exception);
      }
    } else {
      return NetworkSuccess<List<ProductEntity>>(products);
    }
  }

  @override
  bool addProductToCart(int productId) =>
      _homeLocalDataSourceImp.addProductToCart(productId);
}
