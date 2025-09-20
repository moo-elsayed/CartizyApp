import 'package:cartizy_app_nti/feature/auth/data/api/auth_api.dart';
import 'package:cartizy_app_nti/feature/auth/data/repo_implementation/data_source/auth_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:cartizy_app_nti/feature/auth/domain/use_cases/register_use_case.dart';
import 'package:cartizy_app_nti/feature/home/data/api/home_api.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/data_sources/home_local_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/data_sources/home_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/repo/home_repo_imp.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/get_all_categories_use_case.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:get_it/get_it.dart';
import '../../feature/auth/data/repo_implementation/repo/auth_repo_imp.dart';
import '../../feature/home/domain/use_cases/add_product_to_cart_use_case.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(AuthRepoImp(AuthRemoteDataSourceImp(AuthApi.instance))),
  );

  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(AuthRepoImp(AuthRemoteDataSourceImp(AuthApi.instance))),
  );

  getIt.registerSingleton<HomeRepoImp>(
    HomeRepoImp(
      HomeRemoteDataSourceImp(HomeApi.instance),
      HomeLocalDataSourceImp(),
    ),
  );

  getIt.registerSingleton<GetAllCategoriesUseCase>(
    GetAllCategoriesUseCase(getIt.get<HomeRepoImp>()),
  );

  getIt.registerSingleton<GetProductsByCategoryUseCase>(
    GetProductsByCategoryUseCase(getIt.get<HomeRepoImp>()),
  );

  getIt.registerSingleton<AddProductToCartUseCase>(
    AddProductToCartUseCase(getIt.get<HomeRepoImp>()),
  );
}
