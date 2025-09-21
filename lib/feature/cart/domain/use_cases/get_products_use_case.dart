import 'package:cartizy_app_nti/feature/cart/domain/repo_contract/repo/cart_repo.dart';
import '../../../../core/entities/product_entity.dart';

class GetProductsUseCase {
  GetProductsUseCase(this._cartRepo);

  final CartRepo _cartRepo;

  List<ProductEntity> call() => _cartRepo.getProducts();
}
