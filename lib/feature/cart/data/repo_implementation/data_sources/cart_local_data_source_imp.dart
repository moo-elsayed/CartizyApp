import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/core/helpers/hive_helper.dart';
import 'package:hive/hive.dart';
import '../../../domain/repo_contract/data_sources/cart_local_data_source.dart';

class CartLocalDataSourceImp implements CartLocalDataSource {
  @override
  List<ProductEntity> getProducts() {
    var box = Hive.box<ProductEntity>(HiveHelper.productsBox);
    return box.values.where((element) => element.inCart).toList();
  }

  @override
  Future<bool> removeProduct(int productId) async {
    var box = Hive.box<ProductEntity>(HiveHelper.productsBox);
    int index = box.values.toList().indexWhere(
      (element) => element.id == productId,
    );
    if (box.values.toList()[index].inCart) {
      box.values.toList()[index].inCart = false;
      box.putAt(index, box.values.toList()[index]);
      return true;
    }
    return false;
  }
}
