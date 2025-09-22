import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import '../../../../../core/helpers/network_response.dart';
import '../../../../../core/entities/product_entity.dart';

abstract class HomeRepo {
  Future<NetworkResponse<List<CategoryEntity>>> getAllCategories();

  Future<NetworkResponse<List<ProductEntity>>> getProductsByCategory(
    int categoryId,
  );

  bool addProductToCart(int productId);
}
