import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/repo_contract/data_sources/home_local_data_source.dart';
import 'package:hive/hive.dart';
import '../../../../../core/helpers/hive_helper.dart';

class HomeLocalDataSourceImp implements HomeLocalDataSource {
  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    final box = Hive.box<CategoryEntity>(HiveHelper.categoriesBox);
    final categories = box.values.toList();
    return categories;
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(int categoryId) async {
    final box = Hive.box<ProductEntity>(HiveHelper.productsBox);
    final products = box.values.toList();
    return products
        .where((element) => element.category.id == categoryId)
        .toList();
  }

  @override
  bool addProductToCart(ProductEntity product) {
    final box = Hive.box<ProductEntity>(HiveHelper.cartBox);

    final exists = box.values.any((p) => p.id == product.id);

    if (exists) {
      return false;
    }

    box.add(product);
    return true;
  }
}
