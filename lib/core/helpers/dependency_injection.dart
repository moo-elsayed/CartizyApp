import 'package:cartizy_app_nti/feature/auth/data/api/auth_api.dart';
import 'package:cartizy_app_nti/feature/auth/data/repo_implementation/data_source/auth_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:cartizy_app_nti/feature/auth/domain/use_cases/register_use_case.dart';
import 'package:get_it/get_it.dart';
import '../../feature/auth/data/repo_implementation/repo/auth_repo_imp.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(AuthRepoImp(AuthRemoteDataSourceImp(AuthApi.instance))),
  );

  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(AuthRepoImp(AuthRemoteDataSourceImp(AuthApi.instance))),
  );
}
