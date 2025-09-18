import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/core/helpers/shared_preferences_manager.dart';
import 'package:cartizy_app_nti/feature/auth/data/DTOs/request/login_request_dto.dart';
import 'package:cartizy_app_nti/feature/auth/data/DTOs/response/login_response_dto.dart';
import 'package:cartizy_app_nti/feature/auth/domain/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(LoginInitial());

  final AuthRepo _authRepo;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final request = LoginRequestDto(email: email, password: password);
    var result = await _authRepo.login(request);

    switch (result) {
      case NetworkSuccess<LoginResponseDto>():
        _saveTokens(result);
        emit(LoginSuccess());
      case NetworkFailure<LoginResponseDto>():
        emit(LoginFailure(result.exception.toString()));
    }
  }

  void _saveTokens(NetworkSuccess<LoginResponseDto> result) {
    SharedPreferencesManager.setUserToken(result.data?.accessToken ?? '');
    SharedPreferencesManager.setRefreshToken(result.data?.refreshToken ?? '');
  }
}
