import 'package:cartizy_app_nti/feature/profile/domain/repo_contract/repo/profile_repo.dart';
import '../../../../core/entities/user_response_entity.dart';
import '../../../../core/helpers/network_response.dart';
import '../entities/user_request_entity.dart';

class UpdateProfileUseCase {
  UpdateProfileUseCase(this._profileRepo);

  final ProfileRepo _profileRepo;

  Future<NetworkResponse<UserResponseEntity>> call({
    required UserRequestEntity user,
    required int id,
  }) => _profileRepo.updateProfile(user: user, id: id);
}
