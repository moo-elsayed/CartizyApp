import 'package:cartizy_app_nti/feature/auth/domain/repo_contract/repo/auth_repo.dart';
import '../../../../core/helpers/network_response.dart';
import '../../../../core/helpers/shared_preferences_manager.dart';
import '../entities/response/login_response_entity.dart';

class LoginUseCase {
  LoginUseCase(this._authRepo);

  final AuthRepo _authRepo;

  Future<NetworkResponse<LoginResponseEntity>> call({
    required String email,
    required String password,
  }) async {
    final result = await _authRepo.login(password: password, email: email);

    switch (result) {
      case NetworkSuccess<LoginResponseEntity>():
        _saveTokens(result);
        return NetworkSuccess<LoginResponseEntity>(result.data);
      case NetworkFailure<LoginResponseEntity>():
        return NetworkFailure<LoginResponseEntity>(result.exception);
    }
  }
}

void _saveTokens(NetworkSuccess<LoginResponseEntity> result) {
  SharedPreferencesManager.setUserToken(result.data?.accessToken ?? '');
  SharedPreferencesManager.setRefreshToken(result.data?.refreshToken ?? '');
}
