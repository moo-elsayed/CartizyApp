import '../../../../../core/entities/user_entity.dart';
import '../../../../../core/helpers/network_response.dart';

abstract class ProfileRepo {
  Future<NetworkResponse<UserEntity>> getProfile();
}
