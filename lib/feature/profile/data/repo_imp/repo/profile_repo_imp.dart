import 'package:cartizy_app_nti/core/entities/user_response_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/profile/domain/entities/upload_entity.dart';
import 'package:cartizy_app_nti/feature/profile/domain/entities/user_request_entity.dart';
import 'package:cartizy_app_nti/feature/profile/domain/repo_contract/repo/profile_repo.dart';
import 'package:image_picker/image_picker.dart';
import '../data_sources/profile_remote_data_source_imp.dart';

class ProfileRepoImp implements ProfileRepo {
  ProfileRepoImp(this._profileRemoteDataSourceImp);

  final ProfileRemoteDataSourceImp _profileRemoteDataSourceImp;

  @override
  Future<NetworkResponse<UserResponseEntity>> getProfile() =>
      _profileRemoteDataSourceImp.getProfile();

  @override
  Future<NetworkResponse<UploadEntity>> uploadImage(XFile file) =>
      _profileRemoteDataSourceImp.uploadImage(file);

  @override
  Future<NetworkResponse<UserResponseEntity>> updateProfile({
    required UserRequestEntity user,
    required int id,
  }) => _profileRemoteDataSourceImp.updateProfile(user: user, id: id);
}
