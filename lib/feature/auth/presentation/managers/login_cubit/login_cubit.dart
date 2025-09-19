import 'dart:developer';

import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/auth/domain/entities/response/login_response_entity.dart';
import 'package:cartizy_app_nti/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  final LoginUseCase _loginUseCase;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    var result = await _loginUseCase.call(password: password, email: email);

    switch (result) {
      case NetworkSuccess<LoginResponseEntity>():
        emit(LoginSuccess());
      case NetworkFailure<LoginResponseEntity>():
        log(result.exception.toString());
        emit(LoginFailure(result.exception.toString()));
    }
  }
}
