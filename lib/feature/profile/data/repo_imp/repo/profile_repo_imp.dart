import 'package:cartizy_app_nti/core/entities/user_response_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/profile/domain/entities/upload_entity.dart';
import 'package:cartizy_app_nti/feature/profile/domain/entities/user_request_entity.dart';
import 'package:cartizy_app_nti/feature/profile/domain/repo_contract/repo/profile_repo.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/repo_contract/data_sources/profile_local_data_source.dart';
import '../../../domain/repo_contract/data_sources/profile_remote_data_source.dart';

class ProfileRepoImp implements ProfileRepo {
  ProfileRepoImp(
    this._profileRemoteDataSourceImp,
    this._profileLocalDataSourceImp,
  );

  final ProfileRemoteDataSource _profileRemoteDataSourceImp;
  final ProfileLocalDataSource _profileLocalDataSourceImp;

  @override
  Future<NetworkResponse<UserResponseEntity>> getProfile() async {
    UserResponseEntity? userFromLocal = await _profileLocalDataSourceImp
        .getProfile();
    if (userFromLocal != null) {
      return NetworkSuccess<UserResponseEntity>(userFromLocal);
    } else {
      return await _profileRemoteDataSourceImp.getProfile();
    }
  }

  @override
  Future<NetworkResponse<UploadEntity>> uploadImage(XFile file) async =>
      await _profileRemoteDataSourceImp.uploadImage(file);

  @override
  Future<NetworkResponse<UserResponseEntity>> updateProfile({
    required UserRequestEntity user,
    required int id,
  }) async =>
      await _profileRemoteDataSourceImp.updateProfile(user: user, id: id);
}
