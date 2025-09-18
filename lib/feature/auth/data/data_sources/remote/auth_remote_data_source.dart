import 'package:cartizy_app_nti/core/helpers/network_response.dart';

import '../../DTOs/request/login_request_dto.dart';
import '../../DTOs/request/register_request_dto.dart';
import '../../DTOs/response/login_response_dto.dart';
import '../../DTOs/response/register_response_dto.dart';


abstract class AuthRemoteDataSource {
  Future<NetworkResponse<LoginResponseDto>> login(LoginRequestDto request);

  Future<NetworkResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  );
}
