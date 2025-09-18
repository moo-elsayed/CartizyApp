import 'package:cartizy_app_nti/feature/auth/domain/entities/response/login_response_entity.dart';

class LoginResponseDto extends LoginResponseEntity {
  LoginResponseDto({super.accessToken, super.refreshToken});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] as String?;
    refreshToken = json['refresh_token'] as String?;
  }



}
