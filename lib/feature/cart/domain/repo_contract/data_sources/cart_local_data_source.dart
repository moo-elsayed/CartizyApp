import '../../../../../core/entities/product_entity.dart';

abstract class CartLocalDataSource {
  List<ProductEntity> getProducts();

  Future<bool> removeProduct(ProductEntity product);
}
