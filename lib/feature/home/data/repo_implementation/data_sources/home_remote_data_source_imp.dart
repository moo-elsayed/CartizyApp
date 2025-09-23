import 'package:cartizy_app_nti/core/helpers/hive_helper.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/home/data/api/home_api.dart';
import 'package:cartizy_app_nti/feature/home/data/dtos/request/get_all_categories_response_dto.dart';
import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/repo_contract/data_sources/home_remote_data_source.dart';
import 'package:hive/hive.dart';
import '../../../../../core/dtos/get_products_dto.dart';
import '../../../../../core/helpers/shared_preferences_manager.dart';

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  HomeRemoteDataSourceImp(this._homeApi);

  final HomeApi _homeApi;

  @override
  Future<NetworkResponse<List<CategoryEntity>>> getAllCategories() async {
    final result = await _homeApi.getAllCategories();
    switch (result) {
      case NetworkSuccess<List<GetAllCategoriesResponseDto>>():
        List<CategoryEntity> categories =
            result.data?.map((e) => e.toEntity()).toList() ?? [];
        await _cacheCategories(categories);
        await SharedPreferencesManager.setLastFetchTime(DateTime.now());
        return NetworkSuccess<List<CategoryEntity>>(categories);
      case NetworkFailure<List<GetAllCategoriesResponseDto>>():
        return NetworkFailure<List<CategoryEntity>>(result.exception);
    }
  }

  @override
  Future<NetworkResponse<List<ProductEntity>>> getProductsByCategory(
    int categoryId,
  ) async {
    final result = await _homeApi.getProductsByCategory(categoryId);
    switch (result) {
      case NetworkSuccess<List<GetProductsDto>>():
        List<ProductEntity> products =
            result.data?.map((e) => e.toEntity()).toList() ?? [];
        await _cacheProducts(products);
        await SharedPreferencesManager.setLastFetchTime(DateTime.now());
        return NetworkSuccess<List<ProductEntity>>(products);
      case NetworkFailure<List<GetProductsDto>>():
        return NetworkFailure<List<ProductEntity>>(result.exception);
    }
  }

  Future<void> _cacheCategories(List<CategoryEntity> categories) async {
    final box = await Hive.openBox<CategoryEntity>(HiveHelper.categoriesBox);
    await box.clear();
    await box.addAll(categories);
  }

  Future<void> _cacheProducts(List<ProductEntity> products) async {
    final box = await Hive.openBox<ProductEntity>(HiveHelper.productsBox);
    var myBox = box.values
        .where((element) => element.inCart || element.isFavorite)
        .toList();
    await box.clear();
    var addedProducts = products.where((element) => !myBox.contains(element));
    await box.addAll(myBox);
    await box.addAll(addedProducts);
  }
}
