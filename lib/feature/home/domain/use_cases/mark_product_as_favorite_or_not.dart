import 'package:cartizy_app_nti/feature/home/domain/repo_contract/repo/home_repo.dart';

class MarkProductAsFavoriteOrNot {
  MarkProductAsFavoriteOrNot(this._homeRepo);

  final HomeRepo _homeRepo;

  void call(int productId) => _homeRepo.markProductAsFavoriteOrNot(productId);
}
