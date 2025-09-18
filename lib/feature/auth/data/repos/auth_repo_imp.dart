import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/auth/data/DTOs/request/login_request_dto.dart';
import 'package:cartizy_app_nti/feature/auth/data/DTOs/response/login_response_dto.dart';
import 'package:cartizy_app_nti/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:cartizy_app_nti/feature/auth/domain/repos/auth_repo.dart';
import '../DTOs/request/register_request_dto.dart';
import '../DTOs/response/register_response_dto.dart';

class AuthRepoImp implements AuthRepo {
  AuthRepoImp(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<NetworkResponse<LoginResponseDto>> login(
    LoginRequestDto request,
  ) async => await _authRemoteDataSource.login(request);

  @override
  Future<NetworkResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) async => await _authRemoteDataSource.register(request);
}
