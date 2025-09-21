import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/core/helpers/hive_helper.dart';
import 'package:hive/hive.dart';
import '../../../domain/repo_contract/data_sources/cart_local_data_source.dart';

class CartLocalDataSourceImp implements CartLocalDataSource {
  @override
  List<ProductEntity> getProducts() {
    var box = Hive.box<ProductEntity>(HiveHelper.cartBox);
    return box.values.toList();
  }

  @override
  Future<bool> removeProduct(ProductEntity product) async {
    var box = Hive.box<ProductEntity>(HiveHelper.cartBox);
    final key = box.keys.firstWhere(
      (k) => box.get(k) == product,
      orElse: () => null,
    );

    if (key != null) {
      await box.delete(key);
      return true;
    }
    return false;
  }
}
