import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/data_sources/home_local_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/data_sources/home_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/repo_contract/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  HomeRepoImp(this._homeRemoteDataSourceImp, this._homeLocalDataSourceImp);

  final HomeRemoteDataSourceImp _homeRemoteDataSourceImp;
  final HomeLocalDataSourceImp _homeLocalDataSourceImp;

  @override
  Future<NetworkResponse<List<CategoryEntity>>> getAllCategories() async {
    List<CategoryEntity> categories;
    categories = await _homeLocalDataSourceImp.getAllCategories();
    if (categories.isEmpty) {
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
    List<ProductEntity> products;
    products = await _homeLocalDataSourceImp.getProductsByCategory(categoryId);
    if (products.isEmpty) {
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
  bool addProductToCart(ProductEntity product) =>
      _homeLocalDataSourceImp.addProductToCart(product);
}
