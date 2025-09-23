import 'package:cartizy_app_nti/core/dtos/user_response_dto.dart';
import 'package:cartizy_app_nti/core/helpers/shared_preferences_manager.dart';
import 'package:dio/dio.dart';
import '../../../../core/helpers/app_apis.dart';
import '../../../../core/helpers/network_response.dart';

class ProfileApi {
  ProfileApi._();

  static ProfileApi? _instance;

  static ProfileApi get instance => _instance ??= ProfileApi._();

  final Dio _dio = Dio();

  Future<NetworkResponse<UserResponseDto>> getProfile() async {
    try {
      final String userToken = await SharedPreferencesManager.getUserToken();
      final response = await _dio.get(
        '${AppApis.baseUrl}/api/v1/auth/profile',
        options: Options(headers: {'Authorization': 'Bearer $userToken'}),
      );
      return NetworkSuccess<UserResponseDto>(
        UserResponseDto.fromJson(response.data),
      );
    } catch (e) {
      return NetworkFailure<UserResponseDto>(Exception(e.toString()));
    }
  }
}
