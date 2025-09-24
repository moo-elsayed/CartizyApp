import 'package:cartizy_app_nti/feature/profile/domain/repo_contract/repo/profile_repo.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/helpers/network_response.dart';
import '../entities/upload_entity.dart';

class UploadImageUseCase {
  UploadImageUseCase(this._profileRepo);

  final ProfileRepo _profileRepo;

  Future<NetworkResponse<UploadEntity>> call(XFile file) =>
      _profileRepo.uploadImage(file);
}
