import 'package:cartizy_app_nti/feature/profile/domain/entities/user_request_entity.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/entities/user_response_entity.dart';
import '../../../../../core/helpers/network_response.dart';
import '../../entities/upload_entity.dart';

abstract class ProfileRepo {
  Future<NetworkResponse<UserResponseEntity>> getProfile();

  Future<NetworkResponse<UploadEntity>> uploadImage(XFile file);

  Future<NetworkResponse<UserResponseEntity>> updateProfile({
    required UserRequestEntity user,
    required int id,
  });
}
