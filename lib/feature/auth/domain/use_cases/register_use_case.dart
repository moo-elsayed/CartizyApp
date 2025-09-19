import 'package:cartizy_app_nti/feature/auth/domain/repo_contract/repo/auth_repo.dart';
import '../../../../core/helpers/network_response.dart';
import '../entities/response/register_response_entity.dart';

class RegisterUseCase {
  RegisterUseCase(this._authRepo);

  final AuthRepo _authRepo;

  Future<NetworkResponse<RegisterResponseEntity>> call({
    required String email,
    required String password,
    required String name,
  }) async =>
      await _authRepo.register(email: email, password: password, name: name);
}
