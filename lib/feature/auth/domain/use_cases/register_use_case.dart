import 'package:cartizy_app_nti/feature/auth/domain/repo_contract/repo/auth_repo.dart';
import '../../../../core/helpers/network_response.dart';
import '../../../../core/entities/user_entity.dart';

class RegisterUseCase {
  RegisterUseCase(this._authRepo);

  final AuthRepo _authRepo;

  Future<NetworkResponse<UserEntity>> call({
    required String email,
    required String password,
    required String name,
  }) async =>
      await _authRepo.register(email: email, password: password, name: name);
}
