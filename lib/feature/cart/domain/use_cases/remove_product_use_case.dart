import 'package:cartizy_app_nti/feature/cart/domain/repo_contract/repo/cart_repo.dart';
import '../../../../core/entities/product_entity.dart';

class RemoveProductUseCase {
  RemoveProductUseCase(this._cartRepo);

  final CartRepo _cartRepo;

  Future<bool> call(ProductEntity product) async =>
      await _cartRepo.removeProduct(product);
}
