import 'package:cartizy_app_nti/feature/home/domain/repo_contract/repo/home_repo.dart';
import '../../../../core/helpers/network_response.dart';
import '../entities/product_entity.dart';

class GetProductsByCategoryUseCase {
  GetProductsByCategoryUseCase(this._homeRepo);

  final HomeRepo _homeRepo;

  Future<NetworkResponse<List<ProductEntity>>> call(int categoryId) async {
    final result = await _homeRepo.getProductsByCategory(categoryId);

    switch (result) {
      case NetworkSuccess<List<ProductEntity>>():
        return NetworkSuccess<List<ProductEntity>>(result.data);

      case NetworkFailure<List<ProductEntity>>():
        return NetworkFailure<List<ProductEntity>>(result.exception);
    }
  }
}
