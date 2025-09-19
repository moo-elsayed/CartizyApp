class LoginResponseEntity {
  const LoginResponseEntity({this.accessToken = '', this.refreshToken = ''});

  final String accessToken;
  final String refreshToken;
}
