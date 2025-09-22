import 'package:cartizy_app_nti/feature/home/domain/repo_contract/repo/home_repo.dart';

class AddProductToCartUseCase {
  AddProductToCartUseCase(this._homeRepo);

  final HomeRepo _homeRepo;

  bool call(int productId) => _homeRepo.addProductToCart(productId);
}
