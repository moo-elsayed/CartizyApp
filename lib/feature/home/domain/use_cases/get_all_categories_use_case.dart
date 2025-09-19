import '../../../../core/helpers/network_response.dart';
import '../entities/category_entity.dart';
import '../repo_contract/repo/home_repo.dart';

class GetAllCategoriesUseCase {
  GetAllCategoriesUseCase(this._homeRepo);

  final HomeRepo _homeRepo;

  Future<NetworkResponse<List<CategoryEntity>>> call() async {
    final result = await _homeRepo.getAllCategories();
    switch (result) {
      case NetworkSuccess<List<CategoryEntity>>():
        return NetworkSuccess<List<CategoryEntity>>(result.data);
      case NetworkFailure<List<CategoryEntity>>():
        return NetworkFailure<List<CategoryEntity>>(result.exception);
    }
  }
}
