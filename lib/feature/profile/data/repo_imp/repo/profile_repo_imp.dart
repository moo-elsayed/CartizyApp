import 'package:cartizy_app_nti/core/entities/user_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/profile/domain/repo_contract/repo/profile_repo.dart';
import '../data_sources/profile_remote_data_source_imp.dart';

class ProfileRepoImp implements ProfileRepo {
  ProfileRepoImp(this._profileRemoteDataSourceImp);

  final ProfileRemoteDataSourceImp _profileRemoteDataSourceImp;

  @override
  Future<NetworkResponse<UserEntity>> getProfile() =>
      _profileRemoteDataSourceImp.getProfile();

}