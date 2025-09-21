import '../../../../../core/helpers/network_response.dart';
import '../../entities/category_entity.dart';
import '../../../../../core/entities/product_entity.dart';

abstract class HomeRemoteDataSource {
  Future<NetworkResponse<List<CategoryEntity>>> getAllCategories();

  Future<NetworkResponse<List<ProductEntity>>> getProductsByCategory(
    int categoryId,
  );
}
