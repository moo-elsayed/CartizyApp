import '../../../../../core/entities/user_response_entity.dart';

abstract class ProfileLocalDataSource {
  Future<UserResponseEntity?> getProfile();
}
