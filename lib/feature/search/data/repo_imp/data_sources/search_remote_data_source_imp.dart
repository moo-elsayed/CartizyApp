import 'package:cartizy_app_nti/core/dtos/get_products_dto.dart';
import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/search/data/api/search_api.dart';
import '../../../domain/repo_contract/data_sources/search_remote_data_source.dart';

class SearchRemoteDataSourceImp implements SearchRemoteDataSource {
  SearchRemoteDataSourceImp(this._searchApi);

  final SearchApi _searchApi;

  @override
  Future<NetworkResponse<List<ProductEntity>>> getAllProducts() async {
    final result = await _searchApi.getAllProducts();
    switch (result) {
      case NetworkSuccess<List<GetProductsDto>>():
        return NetworkSuccess<List<ProductEntity>>(
          result.data?.map((e) => e.toEntity()).toList() ?? [],
        );
      case NetworkFailure<List<GetProductsDto>>():
        return NetworkFailure<List<ProductEntity>>(result.exception);
    }
  }
}
