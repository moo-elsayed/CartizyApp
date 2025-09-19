import 'package:cartizy_app_nti/feature/auth/domain/entities/response/login_response_entity.dart';
import 'package:cartizy_app_nti/feature/auth/domain/entities/response/register_response_entity.dart';
import '../../../../../core/helpers/network_response.dart';

abstract class AuthRepo {
  Future<NetworkResponse<LoginResponseEntity>> login({
    required String email,
    required String password,
  });

  Future<NetworkResponse<RegisterResponseEntity>> register({
    required String email,
    required String password,
    required String name,
  });
}
