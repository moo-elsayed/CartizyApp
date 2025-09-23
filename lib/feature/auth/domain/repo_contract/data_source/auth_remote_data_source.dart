import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/auth/domain/entities/response/login_response_entity.dart';
import 'package:cartizy_app_nti/core/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<NetworkResponse<LoginResponseEntity>> login({
    required String email,
    required String password,
  });

  Future<NetworkResponse<UserEntity>> register({
    required String email,
    required String password,
    required String name,
  });
}
