import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/auth/data/api/auth_api.dart';
import 'package:cartizy_app_nti/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import '../../DTOs/request/login_request_dto.dart';
import '../../DTOs/request/register_request_dto.dart';
import '../../DTOs/response/login_response_dto.dart';
import '../../DTOs/response/register_response_dto.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  AuthRemoteDataSourceImp(this._authApi);

  final AuthApi _authApi;

  @override
  Future<NetworkResponse<LoginResponseDto>> login(LoginRequestDto request) async =>
      await _authApi.login(request);

  @override
  Future<NetworkResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) async => await _authApi.register(request);
}
