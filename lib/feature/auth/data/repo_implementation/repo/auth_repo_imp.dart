import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/auth/domain/entities/response/login_response_entity.dart';
import 'package:cartizy_app_nti/feature/auth/domain/entities/response/register_response_entity.dart';
import 'package:cartizy_app_nti/feature/auth/domain/repo_contract/data_source/auth_remote_data_source.dart';
import '../../../domain/repo_contract/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  AuthRepoImp(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<NetworkResponse<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async =>
      await _authRemoteDataSource.login(password: password, email: email);

  @override
  Future<NetworkResponse<RegisterResponseEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async => await _authRemoteDataSource.register(
    email: email,
    password: password,
    name: name,
  );
}
