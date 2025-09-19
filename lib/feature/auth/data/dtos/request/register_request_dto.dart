import '../../../../../core/helpers/app_apis.dart';

class RegisterRequestDto {
  RegisterRequestDto({
    required this.name,
    required this.email,
    required this.password,
    this.avatar = AppApis.defaultAvatar,
  });

  String name;
  String email;
  String password;
  String avatar;

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "avatar": avatar,
  };
}
