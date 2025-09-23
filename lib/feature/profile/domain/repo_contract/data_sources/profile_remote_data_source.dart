import 'package:cartizy_app_nti/core/entities/user_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';

abstract class ProfileRemoteDataSource {
  Future<NetworkResponse<UserEntity>> getProfile();
}
