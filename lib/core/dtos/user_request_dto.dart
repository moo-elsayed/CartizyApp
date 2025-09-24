import '../../feature/profile/domain/entities/user_request_entity.dart';
import '../helpers/app_apis.dart';

class UserRequestDto {
  const UserRequestDto({
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

  factory UserRequestDto.fromEntity(UserRequestEntity entity) {
    return UserRequestDto(
      name: entity.name,
      email: entity.email,
      password: entity.password,
      avatar: entity.avatar,
    );
  }
}
