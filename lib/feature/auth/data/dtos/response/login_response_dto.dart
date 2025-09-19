import 'package:cartizy_app_nti/feature/auth/domain/entities/response/login_response_entity.dart';

class LoginResponseDto {
  LoginResponseDto({this.accessToken, this.refreshToken});

  String? accessToken;
  String? refreshToken;

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  LoginResponseEntity toEntity() => LoginResponseEntity(
    accessToken: accessToken ?? '',
    refreshToken: refreshToken ?? '',
  );
}
