import 'package:cartizy_app_nti/core/entities/user_response_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:image_picker/image_picker.dart';
import '../../entities/upload_entity.dart';
import '../../entities/user_request_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<NetworkResponse<UserResponseEntity>> getProfile();

  Future<NetworkResponse<UploadEntity>> uploadImage(XFile file);

  Future<NetworkResponse<UserResponseEntity>> updateProfile({
    required UserRequestEntity user,
    required int id,
  });
}
