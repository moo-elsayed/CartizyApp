import 'package:cartizy_app_nti/feature/search/domain/repo_contract/repo/search_repo.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/helpers/network_response.dart';

class SearchProductsUseCase {
  SearchProductsUseCase(this._searchRepo);

  final SearchRepo _searchRepo;

  Future<NetworkResponse<List<ProductEntity>>> call(String query) async {
    final result = await _searchRepo.getAllProducts();
    switch (result) {
      case NetworkSuccess<List<ProductEntity>>():
        return NetworkSuccess<List<ProductEntity>>(
          result.data
                  ?.where(
                    (product) => product.title.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
                  )
                  .toList() ??
              [],
        );
      case NetworkFailure<List<ProductEntity>>():
        return NetworkFailure<List<ProductEntity>>(result.exception);
    }
  }
}
