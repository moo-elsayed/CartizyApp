import 'package:cartizy_app_nti/feature/auth/domain/entities/request/register_request_entity.dart';
import '../../../../../core/helpers/app_apis.dart';

class RegisterRequestDto extends RegisterRequestEntity {
  RegisterRequestDto({
    required super.name,
    required super.email,
    required super.password,
    super.avatar = AppApis.defaultAvatar,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "avatar": avatar,
  };
}
