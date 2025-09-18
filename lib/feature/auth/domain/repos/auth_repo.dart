import 'package:cartizy_app_nti/feature/auth/data/DTOs/request/login_request_dto.dart';
import '../../../../core/helpers/network_response.dart';
import '../../data/DTOs/request/register_request_dto.dart';
import '../../data/DTOs/response/login_response_dto.dart';
import '../../data/DTOs/response/register_response_dto.dart';

abstract class AuthRepo {
  Future<NetworkResponse<LoginResponseDto>> login(LoginRequestDto request);

  Future<NetworkResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  );
}
