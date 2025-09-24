import 'package:cartizy_app_nti/core/dtos/user_request_dto.dart';
import '../../../../../core/dtos/user_response_dto.dart';
import '../../../../../core/helpers/network_response.dart';
import '../../../domain/entities/response/login_response_entity.dart';
import '../../../../../core/entities/user_response_entity.dart';
import '../../../domain/repo_contract/data_source/auth_remote_data_source.dart';
import '../../DTOs/request/login_request_dto.dart';
import '../../DTOs/response/login_response_dto.dart';
import '../../api/auth_api.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  AuthRemoteDataSourceImp(this._authApi);

  final AuthApi _authApi;

  @override
  Future<NetworkResponse<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequestDto(email: email, password: password);
    final result = await _authApi.login(request);
    switch (result) {
      case NetworkSuccess<LoginResponseDto>():
        return NetworkSuccess<LoginResponseEntity>(result.data?.toEntity());
      case NetworkFailure<LoginResponseDto>():
        return NetworkFailure<LoginResponseEntity>(
          Exception(result.exception),
        );
    }
  }

  @override
  Future<NetworkResponse<UserResponseEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final request = UserRequestDto(
      email: email,
      password: password,
      name: name,
    );
    final result = await _authApi.register(request);
    switch (result) {
      case NetworkSuccess<UserResponseDto>():
        return NetworkSuccess<UserResponseEntity>(result.data?.toEntity());
      case NetworkFailure<UserResponseDto>():
        return NetworkFailure<UserResponseEntity>(
          Exception(result.exception),
        );
    }
  }
}
