import 'package:cartizy_app_nti/feature/auth/data/api/auth_api.dart';
import 'package:cartizy_app_nti/feature/auth/data/data_sources/remote/auth_remote_data_source_imp.dart';
import 'package:cartizy_app_nti/feature/auth/data/repos/auth_repo_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // getIt.registerSingleton<FirebaseAuthRepositoryImplementation>(
  //   FirebaseAuthRepositoryImplementation(),
  // );
  //
  // getIt.registerSingleton<TaskRepositoryImplementation>(
  //   TaskRepositoryImplementation(TaskRemoteDataSourceImplementation()),
  // );

  getIt.registerSingleton<AuthRepoImp>(
    AuthRepoImp(AuthRemoteDataSourceImp(AuthApi.instance)),
  );
}
