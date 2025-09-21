import 'package:cartizy_app_nti/core/entities/product_entity.dart';

abstract class CartRepo {
  List<ProductEntity> getProducts();

  Future<bool> removeProduct(ProductEntity product);
}
