import 'package:cartizy_app_nti/feature/auth/domain/entities/response/register_response_entity.dart';

class RegisterResponseDto extends RegisterResponseEntity {
  RegisterResponseDto({
    super.id,
    super.email,
    super.password,
    super.name,
    super.role,
    super.avatar,
    this.creationAt,
    this.updatedAt,
  });

  String? creationAt;
  String? updatedAt;

  RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  RegisterResponseEntity toEntity() => RegisterResponseEntity(
    id: id,
    email: email,
    password: password,
    name: name,
    role: role,
    avatar: avatar,
  );
}
