import 'package:cartizy_app_nti/core/helpers/hive_helper.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/repo_contract/repo/home_repo.dart';
import '../../../../../core/helpers/shared_preferences_manager.dart';
import '../data_sources/home_local_data_source_imp.dart';
import '../data_sources/home_remote_data_source_imp.dart';

class HomeRepoImp implements HomeRepo {
  HomeRepoImp(this._homeRemoteDataSourceImp, this._homeLocalDataSourceImp);

  final HomeRemoteDataSourceImp _homeRemoteDataSourceImp;
  final HomeLocalDataSourceImp _homeLocalDataSourceImp;

  @override
  Future<NetworkResponse<List<CategoryEntity>>> getAllCategories() async {
    List result = await Future.wait([
      SharedPreferencesManager.getLastFetchTime(),
      _homeLocalDataSourceImp.getAllCategories(),
    ]);
    final lastFetch = result[0];
    List<CategoryEntity> categories = result[1];
    final isCacheValid =
        lastFetch != null &&
        DateTime.now().difference(lastFetch) < HiveHelper.cacheValidity;
    if (categories.isEmpty || !isCacheValid) {
      final result = await _homeRemoteDataSourceImp.getAllCategories();
      switch (result) {
        case NetworkSuccess<List<CategoryEntity>>():
          categories = result.data ?? [];
          await SharedPreferencesManager.setLastFetchTime(DateTime.now());
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
    List result = await Future.wait([
      SharedPreferencesManager.getLastFetchTime(),
      _homeLocalDataSourceImp.getProductsByCategory(categoryId),
    ]);
    final lastFetch = result[0];
    List<ProductEntity> products = result[1];
    final isCacheValid =
        lastFetch != null &&
        DateTime.now().difference(lastFetch) < HiveHelper.cacheValidity;
    if (products.isEmpty || !isCacheValid) {
      final result = await _homeRemoteDataSourceImp.getProductsByCategory(
        categoryId,
      );
      switch (result) {
        case NetworkSuccess<List<ProductEntity>>():
          products = result.data ?? [];
          await SharedPreferencesManager.setLastFetchTime(DateTime.now());
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
