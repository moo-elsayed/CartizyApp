import '../../../../../core/helpers/app_apis.dart';

class RegisterRequestDto {
  const RegisterRequestDto({
    required this.name,
    required this.email,
    required this.password,
    this.avatar = AppApis.defaultAvatar,
  });

  final String name;
  final String email;
  final String password;
  final String avatar;

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "avatar": avatar,
  };
}
