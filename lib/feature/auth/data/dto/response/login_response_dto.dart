class LoginResponseDto {
  String? accessToken;
  String? refreshToken;

  LoginResponseDto({required this.accessToken, required this.refreshToken});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
