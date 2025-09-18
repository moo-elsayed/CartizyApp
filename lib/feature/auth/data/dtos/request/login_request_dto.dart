import 'package:cartizy_app_nti/feature/auth/domain/entities/request/login_request_entity.dart';

class LoginRequestDto extends LoginRequestEntity {
  LoginRequestDto({required super.email, required super.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};

  LoginRequestEntity toEntity() {
    return LoginRequestEntity(email: email, password: password);
  }
}
