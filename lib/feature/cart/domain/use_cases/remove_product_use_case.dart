import 'package:cartizy_app_nti/feature/cart/domain/repo_contract/repo/cart_repo.dart';

class RemoveProductUseCase {
  RemoveProductUseCase(this._cartRepo);

  final CartRepo _cartRepo;

  Future<bool> call(int productId) async =>
      await _cartRepo.removeProduct(productId);
}
