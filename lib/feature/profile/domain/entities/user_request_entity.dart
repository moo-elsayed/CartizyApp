import '../../../../core/helpers/app_apis.dart';

class UserRequestEntity {
  const UserRequestEntity({
    required this.name,
    required this.email,
    required this.password,
    this.avatar = AppApis.defaultAvatar,
  });

  final String name;
  final String email;
  final String password;
  final String avatar;
}
