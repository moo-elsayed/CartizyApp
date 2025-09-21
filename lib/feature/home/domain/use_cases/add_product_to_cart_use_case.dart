import 'package:cartizy_app_nti/feature/home/domain/repo_contract/repo/home_repo.dart';
import '../../../../core/entities/product_entity.dart';

class AddProductToCartUseCase {
  AddProductToCartUseCase(this._homeRepo);

  final HomeRepo _homeRepo;

  bool call(ProductEntity product) => _homeRepo.addProductToCart(product);
}
