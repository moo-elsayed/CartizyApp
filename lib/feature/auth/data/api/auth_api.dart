import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:dio/dio.dart';
import '../../../../core/helpers/app_apis.dart';
import '../DTOs/request/login_request_dto.dart';
import '../DTOs/request/register_request_dto.dart';
import '../DTOs/response/login_response_dto.dart';
import '../DTOs/response/register_response_dto.dart';

class AuthApi {
  AuthApi._();

  static AuthApi? _instance;

  static AuthApi get instance => _instance ??= AuthApi._();

  final Dio _dio = Dio();

  Future<NetworkResponse<LoginResponseDto>> login(
    LoginRequestDto request,
  ) async {
    try {
      final response = await _dio.post(
        '${AppApis.baseUrl}/api/v1/auth/login',
        data: request.toJson(),
      );
      return NetworkSuccess<LoginResponseDto>(LoginResponseDto.fromJson(response.data));
    } catch (e) {
      return NetworkFailure<LoginResponseDto>(Exception(e.toString()));
    }
  }

  Future<NetworkResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) async {
    try {
      final response = await _dio.post(
        '${AppApis.baseUrl}/api/v1/users/',
        data: request.toJson(),
      );
      return NetworkSuccess<RegisterResponseDto>(RegisterResponseDto.fromJson(response.data));
    } catch (e) {
      return NetworkFailure<RegisterResponseDto>(Exception(e.toString()));
    }
  }
}
