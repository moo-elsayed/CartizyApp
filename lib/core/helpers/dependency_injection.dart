import 'package:cartizy_app_nti/feature/auth/data/api/auth_api.dart';
import 'package:cartizy_app_nti/feature/auth/data/repo_implementation/data_source/auth_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:cartizy_app_nti/feature/auth/domain/use_cases/register_use_case.dart';
import 'package:cartizy_app_nti/feature/cart/data/repo_implementation/data_sources/cart_local_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/cart/data/repo_implementation/repo/cart_repo_imp.dart';
import 'package:cartizy_app_nti/feature/favorite/data/hive/favorite_hive.dart';
import 'package:cartizy_app_nti/feature/favorite/data/repo_imp/data_sources/favorite_local_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/favorite/data/repo_imp/repo/favorite_repo_imp.dart';
import 'package:cartizy_app_nti/feature/favorite/domain/use_cases/get_favorites_use_case.dart';
import 'package:cartizy_app_nti/feature/home/data/api/home_api.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/data_sources/home_local_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/data_sources/home_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/home/data/repo_implementation/repo/home_repo_imp.dart';
import 'package:cartizy_app_nti/feature/favorite/domain/use_cases/toggle_favorite.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/get_all_categories_use_case.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/home_toggle_favorite.dart';
import 'package:cartizy_app_nti/feature/search/data/api/search_api.dart';
import 'package:cartizy_app_nti/feature/search/data/repo_imp/data_sources/search_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/search/data/repo_imp/repo/search_repo_implementation.dart';
import 'package:cartizy_app_nti/feature/search/domain/use_cases/search_products_use_case.dart';
import 'package:get_it/get_it.dart';
import '../../feature/auth/data/repo_implementation/repo/auth_repo_imp.dart';
import '../../feature/cart/domain/use_cases/get_products_use_case.dart';
import '../../feature/cart/domain/use_cases/remove_product_use_case.dart';
import '../../feature/home/domain/use_cases/add_product_to_cart_use_case.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  /// favorite
  getIt.registerSingleton<FavoriteRepoImp>(
    FavoriteRepoImp(FavoriteLocalDataSourceImp(FavoriteHive.instance)),
  );
  getIt.registerSingleton<ToggleFavoriteUseCase>(
    ToggleFavoriteUseCase(getIt.get<FavoriteRepoImp>()),
  );
  getIt.registerSingleton<GetFavoritesUseCase>(
    GetFavoritesUseCase(getIt.get<FavoriteRepoImp>()),
  );

  ////////////////////////////

  /// auth
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(AuthRepoImp(AuthRemoteDataSourceImp(AuthApi.instance))),
  );
  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(AuthRepoImp(AuthRemoteDataSourceImp(AuthApi.instance))),
  );

  ////////////////////////////

  /// home
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

  getIt.registerSingleton<HomeToggleFavoriteUseCase>(
    HomeToggleFavoriteUseCase(getIt.get<ToggleFavoriteUseCase>()),
  );

  ////////////////////////////

  ///cart
  getIt.registerSingleton<CartRepoImp>(CartRepoImp(CartLocalDataSourceImp()));

  getIt.registerSingleton<GetProductsUseCase>(
    GetProductsUseCase(getIt.get<CartRepoImp>()),
  );

  getIt.registerSingleton<RemoveProductUseCase>(
    RemoveProductUseCase(getIt.get<CartRepoImp>()),
  );

  ////////////////////////////

  ///search
  getIt.registerSingleton<SearchProductsUseCase>(
    SearchProductsUseCase(
      SearchRepoImp(SearchRemoteDataSourceImp(SearchApi.instance)),
    ),
  );
}
