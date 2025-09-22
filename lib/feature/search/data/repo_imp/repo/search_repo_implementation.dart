import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/search/domain/repo_contract/data_sources/search_remote_data_source.dart';
import 'package:cartizy_app_nti/feature/search/domain/repo_contract/repo/search_repo.dart';

class SearchRepoImp implements SearchRepo {
  SearchRepoImp(this._searchRemoteDataSource);

  final SearchRemoteDataSource _searchRemoteDataSource;

  @override
  Future<NetworkResponse<List<ProductEntity>>> getAllProducts() =>
      _searchRemoteDataSource.getAllProducts();
}
