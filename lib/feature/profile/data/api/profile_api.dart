import 'package:cartizy_app_nti/core/dtos/user_response_dto.dart';
import 'package:cartizy_app_nti/core/helpers/shared_preferences_manager.dart';
import 'package:cartizy_app_nti/feature/profile/data/dtos/response/upload_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/dtos/user_request_dto.dart';
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

  Future<NetworkResponse<UserResponseDto>> updateProfile({
    required UserRequestDto user,
    required int id,
  }) async {
    try {
      final response = await _dio.put(
        '${AppApis.baseUrl}/api/v1/users/$id',
        data: user.toJson(),
      );
      return NetworkSuccess<UserResponseDto>(
        UserResponseDto.fromJson(response.data),
      );
    } catch (e) {
      return NetworkFailure<UserResponseDto>(Exception(e.toString()));
    }
  }

  Future<NetworkResponse<UploadResponseDto>> uploadImage(XFile file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      var response = await _dio.post(
        '${AppApis.baseUrl}/api/v1/files/upload',
        data: formData,
      );
      return NetworkSuccess<UploadResponseDto>(
        UploadResponseDto.fromJson(response.data),
      );
    } catch (e) {
      return NetworkFailure<UploadResponseDto>(Exception(e.toString()));
    }
  }
}
