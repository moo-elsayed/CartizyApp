import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/cart/domain/repo_contract/repo/cart_repo.dart';
import '../../../domain/repo_contract/data_sources/cart_local_data_source.dart';

class CartRepoImp implements CartRepo {
  CartRepoImp(this._cartLocalDataSource);

  final CartLocalDataSource _cartLocalDataSource;

  @override
  List<ProductEntity> getProducts() => _cartLocalDataSource.getProducts();

  @override
  Future<bool> removeProduct(int productId) async =>
      await _cartLocalDataSource.removeProduct(productId);
}
