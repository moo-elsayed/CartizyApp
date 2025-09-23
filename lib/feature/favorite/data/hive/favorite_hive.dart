import 'package:hive/hive.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/helpers/hive_helper.dart';

class FavoriteHive {
  FavoriteHive._();

  static FavoriteHive? _instance;

  static FavoriteHive get instance => _instance ??= FavoriteHive._();

  void toggleFavorite(int productId) {
    final box = Hive.box<ProductEntity>(HiveHelper.productsBox);
    int index = box.values.toList().indexWhere(
      (element) => element.id == productId,
    );
    if (index == -1) {
      return;
    }
    if (box.values.toList()[index].isFavorite) {
      box.values.toList()[index].isFavorite = false;
      box.putAt(index, box.values.toList()[index]);
    } else {
      box.values.toList()[index].isFavorite = true;
      box.putAt(index, box.values.toList()[index]);
    }
  }

  List<ProductEntity> getFavoriteProducts() {
    final box = Hive.box<ProductEntity>(HiveHelper.productsBox);
    return box.values.toList().where((element) => element.isFavorite).toList();
  }
}
