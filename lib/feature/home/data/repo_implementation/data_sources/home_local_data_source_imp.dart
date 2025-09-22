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
  bool addProductToCart(int productId) {
    final box = Hive.box<ProductEntity>(HiveHelper.productsBox);
    int index = box.values.toList().indexWhere((element) => element.id == productId);
    if (box.values.toList()[index].inCart) {
      return false;
    } else {
      box.values.toList()[index].inCart = true;
      box.putAt(index, box.values.toList()[index]);
      return true;
    }
  }
}
