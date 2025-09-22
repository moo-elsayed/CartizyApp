import '../../entities/category_entity.dart';
import '../../../../../core/entities/product_entity.dart';

abstract class HomeLocalDataSource {
  Future<List<CategoryEntity>> getAllCategories();

  Future<List<ProductEntity>> getProductsByCategory(int categoryId);

  bool addProductToCart(int productId);
}
