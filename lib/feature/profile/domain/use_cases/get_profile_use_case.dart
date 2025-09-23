import 'package:cartizy_app_nti/feature/profile/domain/repo_contract/repo/profile_repo.dart';
import '../../../../core/entities/user_entity.dart';
import '../../../../core/helpers/network_response.dart';

class GetProfileUseCase {
  GetProfileUseCase(this._profileRepo);

  final ProfileRepo _profileRepo;

  Future<NetworkResponse<UserEntity>> getProfile() => _profileRepo.getProfile();
}
